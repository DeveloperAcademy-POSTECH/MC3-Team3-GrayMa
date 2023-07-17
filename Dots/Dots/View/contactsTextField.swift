//
//  contactsTextField.swift
//  Dots
//
//  Created by Kim Andrew on 2023/07/17.
//

import SwiftUI

struct contactsTextField: View {
    
    @State var text : String
    @State var serchAble : Bool
    @State var delAble : Bool
    
    var body: some View {
        ZStack {
            //외각 디자인
            RoundedRectangle(cornerRadius: 40)
                .strokeBorder(Color.gray, lineWidth: 1)
            .frame(width: 361, height: 56)
            
            HStack{
                if serchAble{
                    Button {
                        //돋보기 버튼 기능
                        print("push")
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                    }
                }
                
                TextField("", text: $text)
                    .frame(width: 280)
                
                if delAble{
                    Button {
                        print("X push")
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .foregroundColor(.gray)
                            .frame(width: 24, height: 24)
                    }
                }
            }
        }
    }
}

struct contactsTextField_Previews: PreviewProvider {
    static var previews: some View {
        contactsTextField(text: "dj",serchAble: true, delAble: true)
    }
}
