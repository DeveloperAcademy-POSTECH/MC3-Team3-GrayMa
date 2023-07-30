//
//  contactsUserProfile.swift
//  Dots
//
//  Created by Kim Andrew on 2023/07/19.
//

import SwiftUI

struct ProfileIamgeSelect : View{
    
    @Binding var coreDataUserIdx : Int
    @State var userName : String
    
    var body: some View {
        VStack{
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
            }
            Spacer()
                .frame(height: 4)
            //디버깅
            //Text("\(index)")
            
            HStack(alignment: .center){
                ForEach(1...5, id: \.self) {idx in
                    ZStack {
                        Group {
                            Circle()
                                .foregroundStyle(Color.theme.secondary)
                            Image("user_default_profile \(idx)")
                                .resizable()
                                .scaledToFit()
                                .onTapGesture {
                                    coreDataUserIdx = idx
                                }
                        }
                        .frame(width: 64)
                    }
                }
            }
            .padding(16)
        }
    }
}

//struct contactsUserProfile_Previews: PreviewProvider {
//    static var previews: some View {
//        contactsUserProfile(userName: "김앤디", userProfileIdx: 0)
//    }
//}
