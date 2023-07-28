//
//  ContactsEmailField.swift
//  Dots
//
//  Created by Kim Andrew on 2023/07/26.
//

import SwiftUI

struct ContactsEmailField: View {
    
    //EmailField가 가져야할 변수
    @Binding var UserInputEmail : String
    @State var fieldFocus : Bool
    
    //input error 핸들링
    @State var inputError = false
    @State var textColor = Color.theme.gray
    @State var fieldColor = Color("bgBlank")
    let errorMessage = "@, .com 들어가야됨"
    
    var body: some View {
        VStack (alignment: .leading) {
            
            Text("이메일")
                .foregroundColor(textColor)
            
            ZStack {
                //외각 디자인
                RoundedRectangle(cornerRadius: 40)
                    .frame(width: 361, height: 56)
                    .foregroundColor(fieldColor)
                
                HStack{
                    
                    Spacer()
                        .frame(width: 19,height: 20)
                    
                    TextField("abc@abc.com", text: $UserInputEmail)
                        
                        .onTapGesture { fieldFocus = true }
                        //return 눌렸을때
                        .onReceive(NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)) { _ in
                            fieldFocus = false
                        }
                        .frame(width: 280)
                    
                    Spacer()
                    
                    //text의 값이 없을 경우 X버튼이 나오지 않습니다.
                    if !UserInputEmail.isEmpty && fieldFocus{
                        Button {
                            print("X push")
                            //버튼을 누르면 Text를 초기화합니다.
                            UserInputEmail = ""
                        } label: {
                            Image(systemName: "x.circle.fill")
                                .resizable()
                                .foregroundColor(.gray)
                                .frame(width: 24, height: 24)
                        }
                        .onAppear{fieldColor = Color("secondary")}
                        
                    //입력이 끝나고 return을 받으면 값이 참인지 판단합니다.
                    }else if !UserInputEmail.isEmpty && !fieldFocus{
                        compareEmail(compareText: UserInputEmail)
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
    
    //email의 형식이 올바른지 확인
    private struct compareEmail : View {
        
        let emailCondition : Character = "@"
        let emailCondition2 = ".com"
        @State var compareText : String

        var body: some View {
            if compareText.contains(emailCondition) && compareText.suffix(4) == emailCondition2{
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .foregroundColor(.green)
                    .frame(width: 24, height: 24)
            }else{
                Image(systemName: "exclamationmark.circle.fill")
                    .resizable()
                    .foregroundColor(.red)
                    .frame(width: 24, height: 24)
            }
        }
    }
}
