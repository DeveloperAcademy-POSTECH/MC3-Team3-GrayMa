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
            .frame(height: 84)
        }
        .frame(maxHeight: .infinity)
        .background(Color.theme.bgPrimary)
    }
}

extension CustomConnectionList {
    private var ProfileImage: some View {
        ZStack {
            Group {
                Circle()
                    .foregroundColor(Color.theme.secondary)
                Image("user_default_profile \(entity.profileImageIndex == 0 ? 1 : entity.profileImageIndex)")
                    .resizable()
                    .scaledToFit()
            }
            .frame(width: 64)
        }
    }
    
    private var DefaultUserInfo: some View {
        HStack {
            Text(entity.name ?? "이름")
                .modifier(boldCallout(colorName: .theme.gray5Dark))
                .lineLimit(1)
                .fixedSize()
                .minimumScaleFactor(0.5)
            if let company = entity.company  {
                if company != "" {
                    Text(company + "・" + entity.job!)
                        .modifier(regularCallout(colorName: .theme.gray5Dark))
                        .lineLimit(1)
                        .fixedSize()
                        .frame(alignment: .leading)
                        .minimumScaleFactor(0.5)
                }
                else {
                    Text(entity.job!)
                        .modifier(regularCallout(colorName: .theme.gray5Dark))
                        .lineLimit(1)
                        .fixedSize()
                        .frame(alignment: .leading)
                        .minimumScaleFactor(0.5)
                }
              
            } else {
                Text(entity.job ?? "직업")
                    .modifier(regularCallout(colorName: .theme.gray5Dark))
                    .padding(.leading,16)
            }
        }
    }
    
    private var StrengthSet: some View {
        HStack {
            if let strengthList = entity.strengthSet?.allObjects as? [StrengthEntity] {
                ForEach(strengthList.prefix(2)) { strength in
                    Text(strength.strengthName ?? "스트렝쓰")
                        .truncationMode(.tail)
                        .modifier(regularCaption1(colorName: .theme.text))
                        .padding(.horizontal, 9.5)
                        .frame(minWidth: 0,maxWidth: (UIScreen.main.bounds.width - 200 )/2)
                        .lineLimit(1)
                        .background(Color.theme.secondary)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .strokeBorder(Color.theme.secondary, lineWidth: 1)
                        )
                        .fixedSize()
                    
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
