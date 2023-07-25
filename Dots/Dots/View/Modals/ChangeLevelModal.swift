//
//  ChangeLevelModal.swift
//  Dots
//
//  Created by Jae Ho Yoon on 7/25/23.
//

import SwiftUI

struct ChangeLevelModal: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var dotsModel: DotsModel
    @Binding var selectedLevel: Int
    
    let strengthName: String
    let images = StrengthLevelImage.allCases
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("강점 레벨 선택")
                        .modifier(semiBoldTitle3(colorName: .theme.gray5Dark))
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.top, 23)
                
                Spacer()
                
                HStack(spacing: 30) {
                    ForEach (images.indices, id: \.self) { index in
                        Image(images[index].rawValue)
                            .resizable()
                            .scaledToFit()
                            .frame(height: images[index].size)
                            .onTapGesture {
                                selectedLevel = index
                            }
                            .overlay() {
                                Circle()
                                    .strokeBorder(images[selectedLevel] == images[index] ? Color.accentColor : Color.clear, lineWidth: 3)
                                    .frame(width: 88,height: 88)
                            }
                    }
                }
                .padding(.horizontal,30)
                
                Spacer()
                
                HStack {
                    SelectBtn(fontWeight: .regular, content: "취소", textColor: .theme.gray5Dark, btnColor: .theme.bgBlank, action: { presentation.wrappedValue.dismiss() })
                    Spacer()
                    // 데이터 베이스 연결시에는 데이터 베이스 저장을 해야하는 버튼
                    SelectBtn(fontWeight: .bold, content: "저장", textColor: .theme.bgPrimary, btnColor: .accentColor, action: {
                        dotsModel.changeLevel(strengthLevel: Int16(selectedLevel), strengthName: strengthName)
                        presentation.wrappedValue.dismiss()
                    })
                }
                .padding(.horizontal,16)
            }
            .allowsTightening(true)
            .padding(.horizontal,16)
            .frame(width: UIScreen.main.bounds.width)
            //            .onAppear {
            //                selectedLevel =
            //            }
        }
    }
}
