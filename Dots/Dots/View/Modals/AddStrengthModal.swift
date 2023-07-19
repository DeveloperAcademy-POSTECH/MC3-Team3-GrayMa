//
//  AddStrengthModal.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/19.
//

import SwiftUI

struct AddStrengthModal: View {
    @EnvironmentObject var dotsModel: DotsModel
    @Binding var strengthName : String
    @Binding var pagenum: Int
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        
        VStack(alignment: .center){
            HStack{
                Text("강점 추가")
                    .font(.system(.title3))
                Spacer()
                CloseBtn(btncolor: Fontcolor.fontGray.colorName, action: {presentation.wrappedValue.dismiss()})
            }
            RoundedRectangle(cornerRadius: 40)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .shadow(radius: 2)
                .foregroundColor(.white)
                .overlay(){
                    HStack{
                        Button {
                            print("검색기능 예정")
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                        }
                        .padding(.leading,14)
                        TextField("예) 디자인 시스템", text: $strengthName)
                            .onChange(of: strengthName){
                                newvalue in if strengthName.count > 20 {
                                    strengthName = String(strengthName.prefix(20))
                                }
                            }
                        Spacer()
                        Text("\(strengthName.count)/20")
                        Button {
                            strengthName = ""
                        } label: {
                            Text("\(Image(systemName: "x.circle.fill"))")
                                .foregroundColor(.gray)
                                .frame(width: 24,height: 24)
                                .padding(.trailing,15)
                        }
                        
                        
                    }
                }
            
            HStack{
                Spacer()
                SelectBtn(fontWeight: .regular, content: "이전", textColor: .gray, btnColor: .accentColor, action:{ presentation.wrappedValue.dismiss()})
                SelectBtn(fontWeight: .bold, content: "다음", textColor: .white, btnColor: .blue,action: {
                    pagenum += 1
                    dotsModel.addStrength(name: strengthName)
                })
                Spacer()
            }
            .frame(maxWidth: .infinity)
            
            
        }
        .interactiveDismissDisabled()
        .allowsTightening(true)
        .padding(.horizontal,16)
        .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height / 4)
        .fixedSize()
    }
}
