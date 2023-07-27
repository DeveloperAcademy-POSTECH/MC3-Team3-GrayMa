//
//  ContactsNameField.swift
//  Dots
//
//  Created by Kim Andrew on 2023/07/26.
//

import SwiftUI

struct ContactsNameField: View {
    
    //NameField가 가져야할 변수
    @Binding var UserInputName : String
    @State var fieldFocus : Bool
    
    //input error 핸들링
    @State var inputError = false
    @State var textColor = Color.black
    @State var fieldColor = Color("bgBlank")
    let errorMessage = "이름은 3자리로 작성해주세요."
    
    var body: some View {
        VStack (alignment: .leading) {
            
            Text("이름")
                .foregroundColor(textColor)
            
            ZStack {
                //외각 디자인
                RoundedRectangle(cornerRadius: 40)
                    .frame(width: 361, height: 56)
                    .foregroundColor(fieldColor)
                
                HStack{
                    
                    Spacer()
                        .frame(width: 19,height: 20)
                    
                    TextField("", text: $UserInputName)
                        
                        .onTapGesture { fieldFocus = true }
                        //return 눌렸을때
                        .onReceive(NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)) { _ in
                            fieldFocus = false
                        }
                        .frame(width: 280)
                    
                    Spacer()
                    
                    //text의 값이 없을 경우 X버튼이 나오지 않습니다.
                    if !UserInputName.isEmpty && fieldFocus{
                        Button {
                            print("X push")
                            //버튼을 누르면 Text를 초기화합니다.
                            UserInputName = ""
                        } label: {
                            Image(systemName: "x.circle.fill")
                                .resizable()
                                .foregroundColor(.gray)
                                .frame(width: 24, height: 24)
                        }
                        .onAppear{fieldColor = Color.theme.secondary}
                        
                    //입력이 끝나고 return을 받으면 값이 참인지 판단합니다.
                    }else if !UserInputName.isEmpty && !fieldFocus{
                        compareTextCount(textMin: 1, textMax: 4, compareText: UserInputName)
                            .onAppear{
                                if !compareTextCountReturn(textMin: 1, textMax: 4, compareText: UserInputName){
                                    fieldColor = Color("AlertBG")
                                    textColor = Color.theme.primary
                                    inputError = true
                                }else {
                                    fieldColor = Color.theme.bgBlank
                                    textColor = Color.theme.gray5Dark
                                    inputError = false
                                }}
                    }
                    
                }
                .frame(width: 340)
            }
            if inputError {
                Text("\(errorMessage)")
                    .foregroundColor(textColor)
                  
            }
        }
    }
    
    //이름, 핸드폰의 input의 길이를 측정 올바른 형식인지 판별합니다.
    private struct compareTextCount : View {
        
        var textMin : Int
        var textMax : Int
        var compareText : String
        
        var body: some View {
            
            if textMin < Int(compareText.count) && Int(compareText.count) < textMax{
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .foregroundColor(Color.theme.alertGreen)
                    .frame(width: 24, height: 24)
            } else {
                Image(systemName: "exclamationmark.circle.fill")
                    .resizable()
                    .foregroundColor(Color.theme.primary)
                    .frame(width: 24, height: 24)
            }
        }
    }
    
}
