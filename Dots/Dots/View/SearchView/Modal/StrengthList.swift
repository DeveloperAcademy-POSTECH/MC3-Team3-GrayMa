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
    @Binding var isKeyboardVisible: Bool
    @Binding var selectedStrength: String
    @State var isChecked: Bool = false
    var body: some View {
        HStack {
            Text(strength)
                .modifier(regularCallout(colorName: .theme.gray5Dark))
                .padding(.leading,44)
            Spacer()
            
            Image(systemName: "checkmark")
                .padding(.trailing, 47)
                .foregroundColor(.theme.primary)
                .hideToBool(strengthName != strength)
        }
        .frame(height: 56)
        .background(strengthName == strength ? Color.theme.secondary : Color.theme.bgPrimary)
        .frame(maxWidth: .infinity)
        .onTapGesture {
            strengthName = strength
            selectedStrength = strengthName
            isKeyboardVisible.toggle()
        }
    }
}

//struct StrengthList_Previews: PreviewProvider {
//    static var previews: some View {
//        StrengthList(strength: "SwiftUI", strengthName: .constant("SwiftUI"))
//    }
//}
