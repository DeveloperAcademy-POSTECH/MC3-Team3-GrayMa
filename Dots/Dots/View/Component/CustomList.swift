//
//  CustomList.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/19.
//

import SwiftUI

enum StrengthLevelImage: String, CaseIterable {
    case weakDot
    case moderateDot
    case strongDot
}

struct CustomList: View {
    var entity: MyStrengthEntity
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 84)
          
            .shadow(radius: 2)
            .overlay()
        {
            HStack(alignment: .center){
                Image(StrengthLevelImage.allCases[Int(entity.strengthLevel)].rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36,height: 36)
                    .padding(.leading,22)
                Text(entity.ownStrength?.strengthName ?? "이름")
                    .font(.system(size: 17,weight: .semibold))
                    .padding(.leading,12)
                Spacer()
                NavigationLink(destination: EmptyView()) {
                    Text("\(Image(systemName: "chevron.right"))")
                        .font(.system(size: 15, weight: .regular))
                        .padding(.trailing, 14)
                }
            }
        }
        .padding(.top, 10)
        .padding(.horizontal,16)
       
        
    }
}
