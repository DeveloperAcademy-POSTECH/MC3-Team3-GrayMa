//
//  CustomConnectionList.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/19.
//

import SwiftUI

struct CustomConnectionList: View {
    var name: String
    var company: String
    var job: String
    var strengths: [String]
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(Color.gray, lineWidth: 0.5)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 84)
            .overlay() {
                VStack(alignment: .leading) {
                    HStack {
                        Text(name)
                            .modifier(semiBoldCallout(colorName: Fontcolor.fontBlack.colorName))
                        Text(company+"・"+job)
                            .modifier(regularCallout(colorName: Fontcolor.fontBlack.colorName))
                            .padding(.leading,16)
                        Spacer()
                    }
                    .padding(.leading,16)
                    NavigationLink(destination: ConnectionDetailView()){   // ConnectionDetailView와 연결
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color.gray)
                            .padding(.leading,336)
                    }
                    HStack {
                        ForEach (strengths.indices,id: \.self) {i in
                            Text(strengths[i])
                                .modifier(contactsStrength(colorName: Color.white))
                            
                        }
                    }
                    .padding(.leading,16)
                }
                
            }
            .padding(.horizontal,16)
    }
}

struct CustomConnectionList_Previews: PreviewProvider {
    static var previews: some View {
        CustomConnectionList(name: "신채은", company: "토스", job: "ios 개발", strengths: ["논리적사고", "Core Data"])
    }
}
