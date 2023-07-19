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
        VStack{
            HStack{
                Text("강점 레벨 선택")
                    .font(.system(.title3))
                    .bold()
                Spacer()
                CloseBtn(btncolor: Fontcolor.fontGray.colorName, action: {presentation.wrappedValue.dismiss()})
            }
            .frame(maxWidth: .infinity)
            .padding(.leading,16)
            .padding(.trailing,21)
            HStack{
                ForEach (images.indices, id: \.self) { index in
                    Image(images[index].rawValue)
                        .resizable()
                        .frame(width: 88,height: 88)
                        .onTapGesture {
                            selectedLevel = index
                        }
                        .overlay(){
                            Circle()
                                .strokeBorder(images[selectedLevel] == images[index] ? Color.blue : Color.clear,lineWidth: 3)
                                .frame(width: 88,height: 88)
                        }
                    
                    
                }
                
            }
            .padding(.horizontal,30)
            HStack{
                SelectBtn(fontWeight: .regular, content: "이전", textColor: .black, btnColor: .gray, action: {pageNum -= 1})
                Spacer()
                // 데이터 베이스 연결시에는 데이터 베이스 저장을 해야하는 버튼
                SelectBtn(fontWeight: .bold, content: "저장", textColor: .white, btnColor: .blue, action: {
                    dotsModel.addMyStrength(strengthLevel: Int16(selectedLevel), strengthName: strengthName)
                    presentation.wrappedValue.dismiss()
                })
            }
            .padding(.horizontal,16)
        }
        .interactiveDismissDisabled()
        .allowsTightening(true)
        .padding(.horizontal,16)
        .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height / 4)
        .fixedSize()
    }
}
