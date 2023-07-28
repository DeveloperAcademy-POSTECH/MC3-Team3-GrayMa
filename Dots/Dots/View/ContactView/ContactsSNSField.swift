//
//  ContactsSNSField.swift
//  Dots
//
//  Created by Kim Andrew on 2023/07/26.
//

import SwiftUI

struct ContactsSNSField: View {
    
    //SNSField가 가져야할 변수
    @Binding var UserInputSNS : String
    @State var fieldFocus : Bool
    
    //input error 핸들링
    @State var inputError = false
    @State var textColor = Color.theme.gray
    @State var fieldColor = Color("bgBlank")
    let errorMessage = "링크드인 주소"
    
    var body: some View {
        VStack (alignment: .leading) {
            
            Text("LinkedIn")
                .foregroundColor(textColor)
            
            ZStack {
                //외각 디자인
                RoundedRectangle(cornerRadius: 40)
                    .frame(width: 361, height: 56)
                    .foregroundColor(fieldColor)
                
                HStack{
                    
                    Spacer()
                        .frame(width: 19,height: 20)
                    
                    TextField("url을 입력해주세요", text: $UserInputSNS)
                        
                        .onTapGesture { fieldFocus = true }
                        //return 눌렸을때
                        .onReceive(NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)) { _ in
                            fieldFocus = false
                        }
                        .frame(width: 280)
                    
                    Spacer()
                    
                    //text의 값이 없을 경우 X버튼이 나오지 않습니다.
                    if !UserInputSNS.isEmpty && fieldFocus{
                        Button {
                            print("X push")
                            //버튼을 누르면 Text를 초기화합니다.
                            UserInputSNS = ""
                        } label: {
                            Image(systemName: "x.circle.fill")
                                .resizable()
                                .foregroundColor(.gray)
                                .frame(width: 24, height: 24)
                        }
                        .onAppear{fieldColor = Color.theme.secondary}
                        
                    //입력이 끝나고 return을 받으면 값이 참인지 판단합니다.
                    }else if !UserInputSNS.isEmpty && !fieldFocus{
                        compareSNS(compareText: UserInputSNS)
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
    private struct compareSNS : View {
        
        let snsCondition = "https://www.linkedin.com/in/"
        @State var compareText : String

        var body: some View {
            if compareText.hasPrefix(snsCondition) {
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

