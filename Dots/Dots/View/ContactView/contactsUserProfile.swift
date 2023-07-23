//
//  contactsUserProfile.swift
//  Dots
//
//  Created by Kim Andrew on 2023/07/19.
//

import SwiftUI

struct contactsUserProfile: View {

    //유저 프로필 정보
    @State var userName : String
    @Binding var CoreDatauserProfileIdx : Int
    
    var body: some View {
        profileIamgeSelect(CoreDataUserIdx: $CoreDatauserProfileIdx, userName: userName)
    }
}

struct profileIamgeSelect : View{
    
    @Binding var CoreDataUserIdx : Int
    @State var userName : String
    
    var body: some View {
        VStack{
            ZStack{
                if (CoreDataUserIdx == 0){
                    //이미지 선택 디자인
                    Ellipse()
                        .frame(width: 88, height: 88)
                        .foregroundColor(.gray)
                    
                    Text("\(convertUserName(name: userName))")
                }else {
                    Image("user_default_profile \(CoreDataUserIdx)")
                        .resizable()
                        .frame(width: 88, height: 88)
                }
            }
            
            //디버깅
            //Text("\(index)")
            
            HStack(alignment: .center){
                ForEach(1...5, id: \.self) {idx in
                    Image("user_default_profile \(idx)")
                        .resizable()
                        .frame(width: 64, height: 64)
                        .padding(.leading, 6)
                        .onTapGesture {
                            CoreDataUserIdx = idx
                        }
                }
            }
        }
    }
}

//struct contactsUserProfile_Previews: PreviewProvider {
//    static var previews: some View {
//        contactsUserProfile(userName: "김앤디", userProfileIdx: 0)
//    }
//}
