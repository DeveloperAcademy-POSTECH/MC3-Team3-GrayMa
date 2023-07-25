//
//  SelectLevelModal.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/19.
//

import SwiftUI

struct SelectLevelModal: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var dotsModel: DotsModel
    let images = StrengthLevelImage.allCases
    let levels = ["하","중","상"]
    @Binding var strengthName: String
    @Binding var pageNum: Int
    @Binding var selectedLevel : Int
    
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
                
                HStack(spacing: 65) {
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
                    SelectBtn(fontWeight: .regular, content: "이전", textColor: .theme.gray5Dark, btnColor: .theme.bgBlank, action: {pageNum -= 1})
                    Spacer()
                    // 데이터 베이스 연결시에는 데이터 베이스 저장을 해야하는 버튼
                    SelectBtn(fontWeight: .bold, content: "저장", textColor: .theme.bgPrimary, btnColor: .accentColor, action: {
                        dotsModel.addMyStrength(strengthLevel: Int16(selectedLevel), strengthName: strengthName)
                        presentation.wrappedValue.dismiss()
                    })
                }
                .padding(.horizontal,16)
            }
            .allowsTightening(true)
            .padding(.horizontal,16)
            .frame(width: UIScreen.main.bounds.width)
        }
       
        
    }
}
