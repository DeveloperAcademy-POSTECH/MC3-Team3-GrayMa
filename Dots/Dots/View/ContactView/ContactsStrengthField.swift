//
//  ContactsStrengthField.swift
//  Dots
//
//  Created by Kim Andrew on 2023/07/26.
//

import SwiftUI

struct ContactsStrengthField: View {
    
    //JobField가 가져야할 변수
    @Binding var UserInputStrengthArr : [String]
    
    @State var UserInputStrength = ""
    
    //Field 컨트롤 옵션
    @State var selected = false
    
    
    //input error 핸들링
    @State var inputError = false
    @State var textColor = Color.black
    @State var fieldColor = Color("bgBlank")
    let errorMessage = "최대 6개까지 가능"
    
    var body: some View {
        VStack (alignment: .leading) {
            
            Text("강점")
                .foregroundColor(textColor)
            
            ZStack {
                //외각 디자인
                RoundedRectangle(cornerRadius: 40)
                    .foregroundColor(fieldColor)
                    .frame(width: 361, height: 56)
                
                HStack{
                    
                    //돋보기 보양
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                    
                    Text("\(UserInputStrength)")
                    
                    TextField("", text: $UserInputStrength)
                        .onTapGesture {
                            selected = true
                        }
        
                    //return 눌렸을때
                        .onReceive(NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)) { _ in
                            selected = false
                            UserInputStrengthArr.append(UserInputStrength)
                        }
                        .frame(width: 280)
                    
                    Spacer()
                    
                    if !UserInputStrength.isEmpty {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .foregroundColor(Color("AlertGreen"))
                            .frame(width: 24, height: 24)
                            .onAppear{
                                fieldColor = Color("secondary")
                            }
                    }
                }
                .frame(width: 340)
            }
            
            //모달에서 직무가 하나라도 있는지 리턴 받아야함
            Text("\(errorMessage)")
                .foregroundColor(textColor)
                .opacity(inputError ? 1 : 0)
        }
    }
}

