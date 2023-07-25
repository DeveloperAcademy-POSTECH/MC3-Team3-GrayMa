//
//  contactsUserProfile.swift
//  Dots
//
//  Created by Kim Andrew on 2023/07/19.
//

import SwiftUI

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
                        .foregroundColor(Color("secondary"))
                   
                    Text("\(convertUserName(name: userName))")
                }else {
                    Image("user_default_profile \(CoreDataUserIdx)")
                        .resizable()
                        .frame(width: 88, height: 88)
                }
            }
            Spacer()
                .frame(height: 20)
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
