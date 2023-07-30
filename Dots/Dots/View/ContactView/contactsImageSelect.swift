//
//  ContactsImageSelect.swift
//  Dots
//
//  Created by Kim Andrew on 2023/07/29.
//

import SwiftUI

struct ContactsImageSelect: View {
    @State var userName : String
    @Binding var coreDataUserIdx: Int
    
    var body: some View {
        ZStack{
            Group {
                Circle()
                    .foregroundStyle(Color.theme.secondary)
                if (coreDataUserIdx == 0){
                    Text("\(convertUserName(name: userName))")
                } else {
                    Image("user_default_profile \(coreDataUserIdx)")
                        .resizable()
                        .scaledToFit()
                }
            }
            .frame(width: 88)
            
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 24, height: 24)
                .offset(x: 30, y: 30)
                .foregroundColor(Color("primary"))
        }
    }
}

//모달뷰 정의
struct ProfileImageModal: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var userName : String
    @Binding var userImageIdx : Int
    
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
            
            ProfileIamgeSelect(coreDataUserIdx: $userImageIdx, userName: userName)
            
            HStack{
                SelectBtn(fontWeight: .regular, content: "취소", textColor: .black, btnColor: Color("bgBlank"), action: {presentationMode.wrappedValue.dismiss()})
                Spacer()
                // 데이터 베이스 연결시에는 데이터 베이스 저장을 해야하는 버튼
                SelectBtn(fontWeight: .bold, content: "완료", textColor: .white, btnColor: Color("primary"), action: {
                    print("완료")
                    //MARK: coreDate 업데이트
                    presentationMode.wrappedValue.dismiss()
                })
            }
            .padding(.horizontal,16)
        }
    }
}

//
//struct contactsImageSelect_Previews: PreviewProvider {
//    static var previews: some View {
//        contactsImageSelect(userName: "김정현")
//    }
//}
