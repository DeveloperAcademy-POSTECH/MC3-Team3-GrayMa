//
//  contactsTextField.swift
//  Dots
//
//  Created by Kim Andrew on 2023/07/17.
//

import SwiftUI
import UIKit

//MARK: Option 0 -> Name, 1 -> Phone, 2 -> email, 3 -> SNS
struct contactsTextField: View {
    
    //textField가 기본적으로 가져야할 옵션 컨트롤
    @State var inputCondition : String
    @State var text : String
    @State var option : Int
    @State var selected = false
    
    //text 전체 삭제 버튼 컨트롤
    @State private var delAble = false
    
    //키보드 옵션 컨트롤 Arr
    let keybordOption = [UIKeyboardType.default, UIKeyboardType.numberPad, UIKeyboardType.default, UIKeyboardType.default]
    
    //input error 컨트롤
    @State var inputError = false
    @State var textColor = Color.black
    @State var fieldColor = Color.gray
    let errorMessage = ["이름은 2~4자리로 작성해주세요.", "번호는 11자리만 가능합니다.", "이메일은 @, .com을 포함해주세요.", "SNS링크는 정확하게"]
    
    //input의 종류에 따른 문자열 비교에 사용
    @State var optionMinText = 0
    @State var optionMaxText = 0

    
    var body: some View {
        
        VStack (alignment: .leading) {
            
            Text("\(inputCondition)")
                .foregroundColor(textColor)
            
            ZStack {
                //외각 디자인
                RoundedRectangle(cornerRadius: 40)
                    .strokeBorder(fieldColor, lineWidth: 1)
                .frame(width: 361, height: 56)
                
                HStack{
                    
                    Spacer()
                        .frame(width: 19,height: 20)
                    
                    TextField("", text: $text)
                        .keyboardType(keybordOption[option])
                        .onChange(of: text) { _ in
                            if (option == 1){
                                if text.count > 10 {
                                    print("\(text.count)")
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }
                            }
                        }
                        .onTapGesture { selected = true }
                        .onReceive(NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)) { _ in
                            selected = false
                        }
                        .frame(width: 280)
                    
                    Spacer()
                    
                    //text의 값이 없을 경우 X버튼이 나오지 않습니다.
                    if !text.isEmpty && selected{
                        Button {
                            print("X push")
                            //버튼을 누르면 Text를 초기화합니다.
                            text = ""
                        } label: {
                            Image(systemName: "x.circle.fill")
                                .resizable()
                                .foregroundColor(.gray)
                                .frame(width: 24, height: 24)
                        }
                        
                    //입력이 끝나고 return을 받으면 값이 참인지 판단합니다.
                    }else if !text.isEmpty && !selected{
                        switch option {
                        case 0: //name
                            compareTextCount(textMin: 1, textMax: 4, compareText: text)
                                .onAppear{
                                    if !compareTextCountReturn(textMin: 1, textMax: 4, compareText: text){
                                        fieldColor = Color.red
                                        textColor = Color.red
                                        inputError = true
                                    }else {
                                        fieldColor = Color.gray
                                        textColor = Color.black
                                        inputError = false
                                    }}
                        case 1: //Phone
                            compareTextCount(textMin: 12, textMax:14, compareText: text)
                                .onAppear{
                                    if !(text.count < 11) {
                                        text = convertPhoneNum(text)
                                        fieldColor = Color.gray
                                        textColor = Color.black
                                        inputError = false
                                    }else {
                                        fieldColor = Color.red
                                        textColor = Color.red
                                        inputError = true
                                    }}
                                
                        case 2: //email
                            compareEmail(compareText: text)
                        case 3: //SNS -> 아직 미완
                            compareEmail(compareText: text)
                        default: //예외 Error
                            compareEmail(compareText: text)
                        }
                    }
                    
                }
                .frame(width: 340)
            }
            Text("\(errorMessage[option])")
                .foregroundColor(textColor)
                .opacity(inputError ? 1 : 0)

        }
    }
}

//이름, 핸드폰의 input의 길이를 측정 올바른 형식인지 판별합니다.
struct compareTextCount : View {
    
    var textMin : Int
    var textMax : Int
    var compareText : String
    
    var body: some View {
        
        if textMin < Int(compareText.count) && Int(compareText.count) < textMax{
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .foregroundColor(.green)
                .frame(width: 24, height: 24)
        } else {
            Image(systemName: "exclamationmark.circle.fill")
                .resizable()
                .foregroundColor(.red)
                .frame(width: 24, height: 24)
        }
    }
}

//input의 형식에 따라 Field의 색상등 옵션을 조절하기 위한 함수
func compareTextCountReturn(textMin : Int, textMax : Int, compareText : String) -> Bool{
    if textMin < Int(compareText.count) && Int(compareText.count) < textMax{
        return true
    } else {
       return false
    }
}

// 입력받은 번호를 000-0000-0000 형식으로 변환
func convertPhoneNum (_ phoneNum : String) -> String{
    
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

//email의 형식이 올바른지 확인
struct compareEmail : View {
    
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

//SNS 링크가 올바른지 확인 -> 미완
struct compareSns : View {
    
    var body: some View{
        Image(systemName: "checkmark.circle.fill")
            .resizable()
            .foregroundColor(.green)
            .frame(width: 24, height: 24)
    }
}

struct contactsTextField_Previews: PreviewProvider {
    static var previews: some View {
        contactsTextField(inputCondition: "Phone", text: "", option: 0)
    }
}
