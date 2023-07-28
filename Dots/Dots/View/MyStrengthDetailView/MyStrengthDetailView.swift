//
//  MyStrengthDetailView.swift
//  Dots
//
//  Created by Jae Ho Yoon on 7/19/23.
//

import SwiftUI

struct MyStrengthDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dotsModel: DotsModel
    @State private var showLevelModal = false
    @State private var showNoteModal = false
    @State var selectedLevel: Int
    
    let myStrengthEntity: MyStrengthEntity
    let images = StrengthLevelImage.allCases
    
    var body: some View {
        VStack {
            HStack {
                Image(images[Int(myStrengthEntity.strengthLevel)].rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(height: images[Int(myStrengthEntity.strengthLevel)].sizeSmall)
                Text(myStrengthEntity.ownStrength?.strengthName ?? "")
                    .modifier(boldLargeTitle(colorName: .theme.gray5Dark))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading, 16.8)
            .padding(.top, 5)
            
            // MARK: -  같은 강점 사람들 리스트
            ScrollView(.horizontal) {
                HStack {
                    ForEach(dummyPortraitData, id: \.self) { entity in
                        PortraitBtn(entity: entity)
                    }
                }
                .padding(.leading, 16)
                .padding(.bottom, 10)
            }
            .scrollIndicators(.never)
            
            // 강점메모 만들기
            Button(action: {
                self.showNoteModal = true
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                    HStack {
                        Group {
                            Image(systemName: "square.and.pencil")
                                .foregroundColor(.white)
                            Text("새로운 기록 작성")
                                .modifier(semiBoldBody(colorName: .theme.bgPrimary))
                        }
                        .modifier(semiBoldBody(colorName: .white))
                    }
                }
                .frame(height: 44)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
            })
            
            // MARK: - 강점메모 리스트
            ScrollView {
                if let notes = myStrengthEntity.notes?.allObjects as? [MyStrengthNoteEntity], !notes.isEmpty {
                    ForEach(notes) { note in
                        CustomDetailList(noteEntity: note)
                            .frame(height: 62)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                } else {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.white)
                        .frame(height: 62)
                        .overlay() {
                            HStack {
                                Text("저장된 기록이 없습니다.")
                                    .modifier(regularSubHeadLine(colorName: .gray))
                                Spacer()
                            }
                            .padding(.leading, 29)
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                }
            }
            .padding(.horizontal, 16)
            .listStyle(PlainListStyle())
        }
        .navigationBarItems(leading: backButton, trailing: Button(action: {
            self.showLevelModal = true
        }) { Text("레벨 선택") })
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.theme.bgMain)
        
        // MARK: - Modal 모음
        // 레벨 선택시 나오는 Modal
        .sheet(isPresented: $showLevelModal){
            ChangeLevelModal(selectedLevel: $selectedLevel, strengthName: myStrengthEntity.ownStrength?.strengthName ?? "")
                .presentationDetents([.height(UIScreen.main.bounds.height * 0.35)])
                .onAppear {
                    self.selectedLevel = Int(self.myStrengthEntity.strengthLevel)
                }
        }
        
        // 새로운 강점노트 클릭시 나오는 Modal
        .sheet(isPresented: $showNoteModal){
            CreateNoteModal(entity: myStrengthEntity, placeholder: "어떤 것을 배웠나요? 자유롭게 기록해주세요.")
        }
    }
    
    
    // 뒤로 가기 커스텀버튼 구현
    private var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.backward")
                Text("내 강점")
            }
        }
    }
}
