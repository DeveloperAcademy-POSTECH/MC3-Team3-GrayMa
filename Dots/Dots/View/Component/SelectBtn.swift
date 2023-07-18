//
//  SelectBtn.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/19.
//

import SwiftUI

struct SelectBtn: View {
    var fontWeight: Font.Weight
    var content: String
    var textColor: Color
    var btnColor: Color
    var action: () -> Void
    var body: some View {
        Button(action: {
            action()
        }) {
            RoundedRectangle(cornerRadius:12)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .foregroundColor(btnColor)
                .overlay(alignment: .center) {
                    Text(content)
                        .foregroundColor(textColor)
                        .fontWeight(fontWeight)
                }
        }    }
}


