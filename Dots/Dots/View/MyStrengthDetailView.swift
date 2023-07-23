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
    @State var showLevelModal = false
    @State var showNoteModal = false
    
    let myStrengthEntity: MyStrengthEntity
    
    var body: some View {
        NavigationStack{
            VStack {
                HStack {
                    Image(StrengthLevelImage.allCases[Int(myStrengthEntity.strengthLevel)].rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                    Text(myStrengthEntity.ownStrength?.strengthName ?? "")
                        .modifier(boldLargeTitle(colorName: .black))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.leading, 16.8)
                
                // MARK: -  같은 강점 사람들 리스트
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(dummyPortraitData, id: \.self) { entity in
                            PortraitBtn(entity: entity)
                        }
                    }
                    .padding(.leading, 16)
                    .padding(.bottom, 14)
                }
                
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
                            }
                            .modifier(semiBoldBody(colorName: .white))
                        }
                    }
                    .frame(height: 44)
                    .padding(.horizontal, 16)
                    
                })
                .padding(.bottom, 10)
                
                // MARK: - 강점메모 리스트
                ScrollView {
                    if dotsModel.myNotes.isEmpty {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 62)
                            .padding(.horizontal, 16)
                            .overlay()
                        {
                            HStack {
                                Text("저장된 기록이 없습니다.")
                                    .modifier(regularSubHeadLine(colorName: .gray))
                                Spacer()
                            }
                            .padding(.leading, 45)
                        }
                    } else {
                        ForEach(dotsModel.myNotes) { entity in
                            CustomDetailList(noteEntity: entity)
                        }
                    }
                }
            }
        }
        .navigationBarItems(leading: backButton, trailing: Button(action: {
            self.showLevelModal = true
        }) { Text("레벨 선택") })
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.95, green: 0.95, blue: 0.97))
        
        // MARK: - Modal 모음
        // 레벨 선택시 나오는 Modal
        .sheet(isPresented: $showLevelModal){
            StrengthModal(pagenum: 1)
                .presentationDetents([.height(UIScreen.main.bounds.height * 0.25)])
        }
        
        // 새로운 강점노트 클릭시 나오는 Modal
        .sheet(isPresented: $showNoteModal){
            StrengthNoteModal()
        }
    }
    
    
    // 뒤로 가기 커스텀버튼 구현
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.backward")
                Text("내 강점")
            }
        }
    }
}
