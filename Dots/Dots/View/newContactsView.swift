//
//  newContactsView.swift
//  Dots
//
//  Created by Kim Andrew on 2023/07/17.
//

import SwiftUI
import Contacts

struct newContactsView: View {
    
    let contactsDetailArr = ["이름 *", "연락처", "이메일", "LinkedIn"]
    let contactsModalArr = ["회사", "직무 *"]
   
    //유저 입력 결과 넣을 Arr
    @State private var userDetailInput = ["","","",""]
    @State private var userModalInput = ["",""]
    
    var body: some View {
        NavigationView{
            ScrollView{
                
                //이미지 추가
                HStack{
                    Image(systemName: "pencil")
                }
                
                VStack (alignment: .leading){
                    
                    //TextField 생성
                    contactsTextField(inputCondition: contactsDetailArr[0], text: "", option: 0)
                    
                    ForEach(0..<2){ i in
                        contactsModalText(inputCondition: contactsModalArr[i], text: "")
                    }
                    
                    ForEach(1..<4){ i in
                        contactsTextField(inputCondition: contactsDetailArr[i], text: "", option: i)
                    }
                }
            }
        }
    }
}

struct newContactsView_Previews: PreviewProvider {
    static var previews: some View {
        newContactsView()
    }
}
