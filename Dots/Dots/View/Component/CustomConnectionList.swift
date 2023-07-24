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
        VStack(alignment: .leading) {
            HStack {
                Text(entity.name ?? "이름")
                    .modifier(semiBoldCallout(colorName: .theme.gray5Dark))
                if let company = entity.company {
                    Text(company + "・" + entity.job!)
                        .modifier(regularCallout(colorName: .theme.gray5Dark))
                        .padding(.leading,16)
                } else {
                    Text(entity.job ?? "직업")
                        .modifier(regularCallout(colorName: .theme.gray5Dark))
                        .padding(.leading,16)
                }
                Spacer()
            }
            .padding(.leading,16)
            
            HStack {
                if let strengthList = entity.strengthSet?.allObjects as? [StrengthEntity] {
                    ForEach(strengthList) { strength in
                        Text(strength.strengthName ?? "스트렝쓰")
                            .modifier(contactsStrength(colorName: .theme.secondary))
                    }
                }
            }
            .padding(.leading,16)
        }
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
    }
}
