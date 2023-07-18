//
//  SelectLevelModal.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/19.
//

import SwiftUI

struct SelectLevelModal: View {
    @Environment(\.presentationMode) var presentaition
    let Images = ["weakdot","moderate dot","strong dot"]
    let levels = ["하","중","상"]
    @Binding var strengthName: String
    @Binding var pageNum: Int
    @Binding var levelList: [String]
    @Binding var strengthList : [String]
    @Binding var selectedLevel : String
    @Binding var level : String
    var body: some View {
        VStack{
            HStack{
                Text("강점 레벨 선택")
                    .font(.system(.title3))
                    .bold()
                Spacer()
                CloseBtn(btncolor: Fontcolor.fontGray.colorName, action: {presentaition.wrappedValue.dismiss()})
            }
            .frame(maxWidth: .infinity)
            .padding(.leading,16)
            .padding(.trailing,21)
            HStack{
                ForEach (Images.indices, id: \.self) { index in
                    Image(Images[index])
                        .resizable()
                        .frame(width: 88,height: 88)
                        .onTapGesture {
                            selectedLevel = Images[index]
                            print(selectedLevel)
                            level = levels[index]
                            print(level)
                        }
                        .overlay(){
                            Circle()
                                .strokeBorder(selectedLevel == Images[index] ? Color.blue : Color.clear,lineWidth: 3)
                                .frame(width: 88,height: 88)
                        }
                    
                    
                }
                
            }
            .padding(.horizontal,30)
            HStack{
                SelectBtn(fontWeight: .regular, content: "이전", textColor: .black, btnColor: .gray, action: {pageNum -= 1})
                Spacer()
                // 데이터 베이스 연결시에는 데이터 베이스 저장을 해야하는 버튼
                SelectBtn(fontWeight: .bold, content: "저장", textColor: .white, btnColor: .blue, action: {presentaition.wrappedValue.dismiss()
                    strengthList.append(strengthName)
                    levelList.append(selectedLevel)
                    print(levelList)
                    print(strengthList)
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
