//
//  contactsModalText.swift
//  Dots
//
//  Created by Kim Andrew on 2023/07/18.
//

import SwiftUI

struct contactsJobCompany: View {
    
    //textField가 기본적으로 가져야할 옵션 컨트롤
    @State var inputCondition : String
    @State var keynameCondition : String = ""
    //선택된 회사 혹은 직무를 표시
    @Binding var text : String
    
    //모달 컨트롤
    @State private var modalVissable = false
    
    //input error 컨트롤
    @State var inputError = false
    @State var textColor = Color.black
    @State var fieldColor = Color("bgBlank")
    let errorMessage = ["직무는 필수 조건입니다."]
    
    var body: some View {
        VStack (alignment: .leading) {
            
            Text("\(inputCondition)")
                .foregroundColor(textColor)
            
            ZStack {
                //외각 디자인
                RoundedRectangle(cornerRadius: 40)
                    //.strokeBorder(Color.gray, lineWidth: 1)
                    .onTapGesture{ modalVissable = true }
                    .sheet(isPresented: $modalVissable) {
                        SearchFilterDetailView(isSheetOn: $modalVissable, companyName:.constant("삼성"), jobName:.constant("개발자"), strengthName:.constant("개발"), type: inputCondition, keyName: keynameCondition)
                    }
                    .foregroundColor(fieldColor)
                .frame(width: 361, height: 56)
                
                HStack{
                  
                    //돋보기 보양
                    Image(systemName: "magnifyingglass")
                        //.resizable()
                        .foregroundColor(.black)
                        //.frame(width: 20,height: 20)
                    
                    Text("\(text)")
                    
                    Spacer()
                    
                    if !text.isEmpty {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .foregroundColor(Color("AlertGreen"))
                            .frame(width: 24, height: 24)
                            .onAppear{
                                fieldColor = Color("primary")
                            }
                    }
                }
                .frame(width: 340)
            }
            
            //모달에서 직무가 하나라도 있는지 리턴 받아야함
            Text("\(errorMessage[0])")
                .foregroundColor(textColor)
                .opacity(inputError ? 1 : 0)
        }
        .onAppear {
            switch inputCondition {
            case "회사":
                return keynameCondition = "recentCompany"
            case "직무 *":
                return keynameCondition = "recentjob"
            default:
                return keynameCondition = ""
            }
        }
    }
}

//임시 모달뷰
struct bindingModalView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var text : String
    
    var body: some View {
        VStack {
            Text("임시 모달뷰")
            TextField("", text: $text)
                .frame(height: 50)
                .border(.blue)
            Button("Close") {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .padding()
    }
}


//struct contactsModalText_Previews: PreviewProvider {
//    static var previews: some View {
//        contactsJobCompany(inputCondition: "회사", text: self)
//    }
//}
