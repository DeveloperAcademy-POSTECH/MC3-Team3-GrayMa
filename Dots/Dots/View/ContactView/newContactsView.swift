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
    
    //유저 이미지 모달 컨트롤
    @State private var userImgModal = false
    @State private var userName = "김앤디" // coredate 연동해야함
    @State private var userImgIdx = 0 // coredate 연동해야함
    
    var body: some View {
        NavigationView{
            ScrollView(showsIndicators: false){
                
                //이미지 추가
                contactsImageSelect(userName: "김앤디")
                    .onTapGesture {
                        userImgModal = true
                    }
                    .sheet(isPresented: $userImgModal) {
                        ProfileImageModal(userName: userName, userImageIdx: userImgIdx)
                            .presentationDetents([.height(UIScreen.main.bounds.height * 0.4)])
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

//struct newContactsView_Previews: PreviewProvider {
//    static var previews: some View {
//        newContactsView()
//    }
//}