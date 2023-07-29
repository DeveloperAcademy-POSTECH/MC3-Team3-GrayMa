//
//  ContactsStrengthField.swift
//  Dots
//
//  Created by Kim Andrew on 2023/07/26.
//

import SwiftUI

struct ContactsStrengthField: View {
    
    //StrengthField가 가져야할 변수
    @Binding var UserInputStrengthArr : [String]
    
    @State var UserInputStrength = ""
    
    //Field 컨트롤 옵션
    @State var modalControl = false
    
    
    //input error 핸들링
    @State var inputError = false
    @State var textColor = Color.theme.gray
    @State var fieldColor = Color("bgBlank")
    let errorMessage = "강점은 최대 6개까지 저장 가능합니다"
    
    var body: some View {
        VStack (alignment: .leading) {
            
            Text("강점 *")
                .foregroundColor(textColor)
            
            ZStack {
                //외각 디자인
                RoundedRectangle(cornerRadius: 40)
                    .foregroundColor(fieldColor)
                    .frame(width: 361, height: 56)
                    .onTapGesture { modalControl = true }
                    .sheet(isPresented: $modalControl){
                        AddStrengthSheet(selectedStrength: $UserInputStrengthArr)
                    }
                
                HStack{
                    
                    //돋보기 보양
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                    
                    Text("\(UserInputStrength)")
                    
                    Spacer()
                    
                    if !UserInputStrengthArr.isEmpty && UserInputStrengthArr.count < 7{
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .foregroundColor(Color.theme.alertGreen)
                            .frame(width: 24, height: 24)
                            .onAppear{
                                fieldColor = Color.theme.bgBlank
                                textColor = Color.theme.gray
                                inputError = false
                            }
                    } else if UserInputStrengthArr.count > 6{
                        Image(systemName: "exclamationmark.circle.fill")
                            .resizable()
                            .foregroundColor(Color.theme.primary)
                            .frame(width: 24, height: 24)
                            .onAppear{
                                fieldColor = Color("AlertBG")
                                textColor = Color.theme.primary
                                inputError = true
                            }
                    }
                }
                .frame(width: 340)
            }
            //모달에서 직무가 하나라도 있는지 리턴 받아야함
            if inputError {
                Text("\(errorMessage)")
                    .foregroundColor(textColor)
            }
        }
    }
}
