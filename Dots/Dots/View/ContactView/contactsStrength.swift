//
//  contactsStrength.swift
//  Dots
//
//  Created by Kim Andrew on 2023/07/19.
//

import SwiftUI

struct contactsStrengthField: View {
    
    //모달 컨트롤
    @State private var modalVissable = false
    
    //input error 컨트롤
    @State var inputStrength : Int
    @State var maxStrength = 6
    @State var textColor = Color.black
    @State var fieldColor = Color("bgBlank")
    let errorMessage = ["직무는 필수 조건입니다."]
    
    @Binding var strengthText : String
    
    var body: some View {
        VStack (alignment: .leading) {
            
            Text("강점 *")
                .foregroundColor(textColor)
            
            ZStack {
                //외각 디자인
                RoundedRectangle(cornerRadius: 40)
                //.strokeBorder(Color.gray, lineWidth: 1)
                    .onTapGesture{ modalVissable = true }
                    .sheet(isPresented: $modalVissable) { bindingModalView (text: $strengthText)}
                    .foregroundColor(fieldColor)
                    .frame(width: 361, height: 56)
                
                HStack{
                    //돋보기 보양
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 19,height: 20)
                    
                    Text("최대 6개까지 등록할 수 있습니다.")
                    
                    Spacer()
                }
                .frame(width: 340)
            }
            
            //모달에서 직무가 하나라도 있는지 리턴 받아야함
            Text("직무는 필수 조건입니다.")
                .foregroundColor(textColor)
                .opacity(inputStrength < maxStrength ? 1 : 0)
        }
    }
}



//struct contactsStrength_Previews: PreviewProvider {
//    static var previews: some View {
//        contactsStrengthField(inputStrength: 0,strengthText: "ㅎㅇ")
//    }
//}
