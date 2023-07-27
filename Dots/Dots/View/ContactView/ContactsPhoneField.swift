//
//  ContactsPhoneField.swift
//  Dots
//
//  Created by Kim Andrew on 2023/07/26.
//

import SwiftUI

struct ContactsPhoneField: View {
    
    //PhoneField가 가져야할 변수
    @Binding var UserInputPhone : String
    @State var fieldFocus : Bool
    
    //input error 핸들링
    @State var inputError = false
    @State var textColor = Color.black
    @State var fieldColor = Color.theme.bgBlank
    let errorMessage = "11자리를 정확히 입력해주세요"
    
    var body: some View {
        VStack (alignment: .leading) {
            
            Text("연락처")
                .foregroundColor(textColor)
            
            ZStack {
                //외각 디자인
                RoundedRectangle(cornerRadius: 40)
                    .frame(width: 361, height: 56)
                    .foregroundColor(fieldColor)
                
                HStack{
                    
                    Spacer()
                        .frame(width: 19,height: 20)
                    
                    TextField("010-0000-0000", text: $UserInputPhone)
                        .keyboardType(UIKeyboardType.numberPad)
                        .onChange(of: UserInputPhone){ _ in
                            if  removeHyphens(from: UserInputPhone).count == 11 {
                                print("\(UserInputPhone.count)")
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                        }
                        .onTapGesture { fieldFocus = true }
                        //return 눌렸을때
                        .onReceive(NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)) { _ in
                            fieldFocus = false
                        }
                        .frame(width: 280)
                    
                    Spacer()
                    
                    //text의 값이 없을 경우 X버튼이 나오지 않습니다.
                    if !UserInputPhone.isEmpty && fieldFocus{
                        Button {
                            print("X push")
                            //버튼을 누르면 Text를 초기화합니다.
                            UserInputPhone = ""
                        } label: {
                            Image(systemName: "x.circle.fill")
                                .resizable()
                                .foregroundColor(.gray)
                                .frame(width: 24, height: 24)
                        }
                        .onAppear{fieldColor = Color.theme.secondary}
                        
                    //입력이 끝나고 return을 받으면 값이 참인지 판단합니다.
                    }else if !UserInputPhone.isEmpty && !fieldFocus{
                        compareTextCount(textMin: 12, textMax:14, compareText: UserInputPhone)
                            .onAppear{
                                if !(UserInputPhone.count < 11) {
                                    UserInputPhone = convertPhoneNum(UserInputPhone)
                                    fieldColor = Color.theme.bgBlank
                                    textColor = Color.theme.gray5Dark
                                    inputError = false
                                }else {
                                    fieldColor = Color("AlertBG")
                                    textColor = Color.theme.primary
                                    inputError = true
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
    
    // 입력받은 번호를 000-0000-0000 형식으로 변환
   private func convertPhoneNum (_ phoneNum : String) -> String{
        
        let cleanedPhoneNumber = phoneNum.replacingOccurrences(of: "-", with: "")
        
        let areaCodeLength = 3
        let firstPartLength = 4
        let secondPartLength = 4
        
        let startIndex = cleanedPhoneNumber.startIndex
        
        let areaCodeEndIndex = cleanedPhoneNumber.index(startIndex, offsetBy: areaCodeLength)
        let firstPartEndIndex = cleanedPhoneNumber.index(areaCodeEndIndex, offsetBy: firstPartLength)
        let secondPartEndIndex = cleanedPhoneNumber.index(firstPartEndIndex, offsetBy: secondPartLength)
        
        let areaCode = cleanedPhoneNumber[startIndex..<areaCodeEndIndex]
        let firstPart = cleanedPhoneNumber[areaCodeEndIndex..<firstPartEndIndex]
        let secondPart = cleanedPhoneNumber[firstPartEndIndex..<secondPartEndIndex]
        
        return "\(areaCode)-\(firstPart)-\(secondPart)"
    }

    //- 삭제
    private func removeHyphens(from input: String) -> String {
        return input.replacingOccurrences(of: "-", with: "")
    }
    
}
