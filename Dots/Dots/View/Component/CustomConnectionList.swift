//
//  CustomConnectionList.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/19.
//

import SwiftUI

struct CustomConnectionList: View {
    let entity: NetworkingPersonEntity
    
    var body: some View {
        Group {
            HStack(spacing: 18) {
                ProfileImage
                    .padding(.leading, 16)
                    
                VStack(alignment: .leading, spacing: 8) {
                    DefaultUserInfo
                    
                    StrengthSet
                }
                
                Spacer()
                
                NavigatorIcon
                    .padding(.trailing, 14)
            }
            .frame(height: 53)
        }
        .frame(maxHeight: .infinity)
        .background(Color.theme.bgPrimary)
    }
}

extension CustomConnectionList {
    private var ProfileImage: some View {
        Image("user_default_profile \(entity.profileImageIndex == 0 ? 1 : entity.profileImageIndex)")
            .resizable()
            .scaledToFit()
    }
    
    private var DefaultUserInfo: some View {
        HStack {
            Text(entity.name ?? "이름")
                .modifier(boldCallout(colorName: .theme.gray5Dark))
            if let company = entity.company {
                Text(company + "・" + entity.job!)
                    .modifier(regularCallout(colorName: .theme.gray5Dark))
                    .padding(.leading,16)
            } else {
                Text(entity.job ?? "직업")
                    .modifier(regularCallout(colorName: .theme.gray5Dark))
                    .padding(.leading,16)
            }
        }
    }
    
    private var StrengthSet: some View {
        HStack(spacing: 8) {
            if let strengthList = entity.strengthSet?.allObjects as? [StrengthEntity] {
                ForEach(strengthList) { strength in
                    Text(strength.strengthName ?? "스트렝쓰")
                        .modifier(contactsStrength(backgroundColor: .theme.secondary, textColor: .theme.text))
                }
            }
        }
    }
    
    private var NavigatorIcon: some View {
        Image(systemName: "chevron.right")
            .resizable()
            .scaledToFit()
            .foregroundColor(.theme.text)
            .frame(height: 20)
    }
}
