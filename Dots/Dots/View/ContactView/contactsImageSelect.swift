//
//  contactsImageSelect.swift
//  Dots
//
//  Created by Kim Andrew on 2023/07/19.
//

import SwiftUI

struct contactsImageSelect: View {
    
    @State var userName : String
    
    var body: some View {
        ZStack{
            //이미지 선택 디자인
            Ellipse()
                .frame(width: 88, height: 88)
                .foregroundColor(.gray)
            
            Text("\(convertUserName(name: userName))")
            
            Image("imagePlusBtn")
                .resizable()
                .frame(width: 24, height: 24)
                .offset(x: 30, y: 30)
        }
    }
}

//모달뷰 정의
struct ProfileImageModal: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var userName : String
    @State var userImageIdx : Int
    
    var body: some View {

        VStack{
            HStack{
                Text("프로필 이미지")
                    .font(.system(.title3))
                    .bold()
                Spacer()
                
            }
            .frame(maxWidth: .infinity)
            .padding(.leading,16)
            .padding(.trailing,21)
            
            Spacer()
                .frame(height: 32)
            
            contactsUserProfile(userName: userName, CoreDatauserProfileIdx: userImageIdx)
            
            HStack{
                SelectBtn(fontWeight: .regular, content: "취소", textColor: .black, btnColor: .gray, action: {presentationMode.wrappedValue.dismiss()})
                Spacer()
                // 데이터 베이스 연결시에는 데이터 베이스 저장을 해야하는 버튼
                SelectBtn(fontWeight: .bold, content: "완료", textColor: .white, btnColor: .blue, action: {
                    print("완료")
                    //MARK: coreDate 업데이트
                    
                })
            }
            .padding(.horizontal,16)
        }
    }
}

//성을 삭제하고 뷰에 올림
func convertUserName(name: String) -> String {
    var modifiedName = name
    
    if !modifiedName.isEmpty {
        modifiedName.removeFirst()
    }
    
    return modifiedName
}

struct contactsImageSelect_Previews: PreviewProvider {
    static var previews: some View {
        contactsImageSelect(userName: "김정현")
    }
}
