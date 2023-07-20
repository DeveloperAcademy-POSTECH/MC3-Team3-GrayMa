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
        RoundedRectangle(cornerRadius: 12)
            .stroke(Color.gray, lineWidth: 0.5)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 84)
            .overlay() {
                VStack(alignment: .leading) {
                    HStack {
                        Text(entity.name ?? "")
                            .modifier(semiBoldCallout(colorName: Fontcolor.fontBlack.colorName))
                        if let company = entity.company {
                            Text(company + "・" + entity.job!)
                                .modifier(regularCallout(colorName: Fontcolor.fontBlack.colorName))
                                .padding(.leading,16)
                        } else {
                            Text(entity.job ?? "")
                                .modifier(regularCallout(colorName: Fontcolor.fontBlack.colorName))
                                .padding(.leading,16)
                        }
                        Spacer()
                    }
                    .padding(.leading,16)
                    NavigationLink(destination: ConnectionDetailView()){
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color.gray)
                            .padding(.leading,336)
                    }
                    
                    HStack {
                        if let strengthList = entity.strengthSet?.allObjects as? [StrengthEntity] {
                            ForEach(strengthList) { strength in
                                Text(strength.strengthName ?? "")
                                    .modifier(contactsStrength(colorName: Color.white))
                            }
                        }
                    }
                    .padding(.leading,16)
                }
                
            }
            .padding(.horizontal,16)
    }
}
