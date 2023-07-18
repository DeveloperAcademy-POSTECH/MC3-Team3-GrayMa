//
//  CloseBtn.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/19.
//

import SwiftUI

struct CloseBtn: View {
    var btncolor: Color
    var action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "x.circle.fill")
                .foregroundColor(btncolor)
        }
    }
}
