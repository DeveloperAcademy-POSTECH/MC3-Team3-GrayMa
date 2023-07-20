//
//  contactsUserProfile.swift
//  Dots
//
//  Created by Kim Andrew on 2023/07/19.
//

import SwiftUI

struct contactsUserProfile: View {
    
    //기본 이미지 Arr
    let defaultImage = ["userName", "img1"]
    
    //유저 프로필 정보
    @State var userName : String
    @State var userProfileIdx : Int
    
    var body: some View {
        profileIamgeSelect(index: userProfileIdx, userName: userName)
    }
}

struct profileIamgeSelect : View{
    
    @State var index : Int
    @State var userName : String
    
    var body: some View {
        VStack{
            ZStack{
                if (index == 0){
                    //이미지 선택 디자인
                    Ellipse()
                        .frame(width: 88, height: 88)
                        .foregroundColor(.gray)
                    
                    Text("\(convertUserName(name: userName))")
                }else {
                    Image("user_default_profile \(index)")
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
                            index = idx
                        }
                }
            }
        }
    }
}

struct contactsUserProfile_Previews: PreviewProvider {
    static var previews: some View {
        contactsUserProfile(userName: "김앤디", userProfileIdx: 0)
    }
}
