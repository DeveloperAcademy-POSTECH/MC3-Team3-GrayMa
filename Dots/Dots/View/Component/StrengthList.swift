//
//  StrengthList.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/19.
//

import SwiftUI

struct StrengthList: View {
    var strength: String
    @Binding var strengthName : String
    @State var isChecked: Bool = false
    var body: some View {
        HStack {
            Text(strength)
                .modifier(regularCallout(colorName: Fontcolor.fontBlack.colorName))
                .padding(.leading,44)
            Spacer()
        }
        .frame(height: 56)
        .background(strengthName == strength ? .gray : .white)
        .frame(maxWidth: .infinity)
        .onTapGesture {
            strengthName = strength
        }
    }
}

struct StrengthList_Previews: PreviewProvider {
    static var previews: some View {
        StrengthList(strength: "SwiftUI", strengthName: .constant("SwiftUI"))
    }
}
