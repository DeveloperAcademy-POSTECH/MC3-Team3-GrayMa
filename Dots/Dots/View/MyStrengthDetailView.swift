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
    @State var showModal = false
    
    var body: some View {
        NavigationStack{
            VStack {
                // 현재 들어온 강점 레벨, 이름 받아야함
                HStack {
                    Image("moderateDot")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                    Text("UX design method")
                        .modifier(boldLargeTitle(colorName: .black))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.leading, 16.8)
                
                // MARK: -  같은 강점 사람들 리스트
                ScrollView(.horizontal) {
                    HStack {
                        PortraitBtn(name: "Marcus", hasPortrait: true, portraitName: "testPortrait")
                    }
                    .padding(.leading, 16)
                    .padding(.bottom, 14)
                }
                
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
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
                
                // MARK: - 현재 강점 디테일 리스트
                ScrollView {
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
                    
//                    ForEach(dotsModel.myNotes, id: \.self) { note in
//                        CustomDetailList(entity: note)
//                    }
                    
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 62)
                        .padding(.horizontal, 16)
                        .overlay()
                    {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Grid System")
                                    .modifier(semiBoldTitle3(colorName: .black))
                                HStack {
                                    Group {
                                        Text("오전 8:47")
                                        Text("손글씨 메모")
                                    }
                                    .modifier(regularSubHeadLine(colorName: .gray))
                                }
                            }
                            .padding(.leading, 45)
                            Spacer()
                        }
                    }
                }
            }
            .navigationBarItems(leading: backButton, trailing: Button(action: {
                self.showModal = true
            }) { Text("레벨 선택") })
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $showModal){
                StrengthModal(pagenum: 1)
                    .presentationDetents([.height(UIScreen.main.bounds.height * 0.25)])
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.95, green: 0.95, blue: 0.97))
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

struct MyStrengthDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MyStrengthDetailView()
    }
}
