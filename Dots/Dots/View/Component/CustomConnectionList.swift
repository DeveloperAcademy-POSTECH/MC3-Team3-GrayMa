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
        HStack(spacing: 18) {
            ProfileImage
                
            VStack(alignment: .leading, spacing: 8) {
                DefaultUserInfo
                
                StrengthSet
            }
            
            Spacer()
            
            NavigatorIcon
        }
        .frame(height: 53)
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

import CoreData

struct CustomConnectionList_Previews: PreviewProvider {
    static var previews: some View {
        let context = NSPersistentContainer(name: "DotsDataContainer").viewContext
        //Test data
        let newEntity = NetworkingPersonEntity(context: context)
        newEntity.peopleID = UUID()
        newEntity.profileImageIndex = Int16(2)
        newEntity.name = "김철수"
        newEntity.company = "apple"
        newEntity.contanctNum = "010-1111-2222"
        newEntity.email = "kkkk@mail.com"
        newEntity.job = "Dev"
        newEntity.linkedIn = "linkedin.com/lol"
        
        return CustomConnectionList(entity: newEntity)
            .previewLayout(.sizeThatFits)
    }
}
