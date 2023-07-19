//
//  KeyboardToolbar.swift
//  Dots
//
//  Created by Jae Ho Yoon on 7/20/23.
//

import SwiftUI

struct KeyboardToolbar: View {
    @Binding var showKeyboardToolbar: Bool
    
    var body: some View {
        Group {
            if showKeyboardToolbar {
                HStack(spacing: 28) {
                    Button(action: {
                        // 날짜 바꾸는 기능
                    }) {
                        Image(systemName: "calendar")
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(height: 18)
                    Button(action: {
                        // 글씨 스타일 바꾸는 기능
                    }) {
                        Image(systemName: "textformat")
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(height: 16)
                    Button(action: {
                        // 글머리 넣는 기능
                    }) {
                        Image(systemName: "list.bullet")
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(height: 16)
                    Spacer()
                }
                .padding(20)
                .padding(.leading, 6)
                .frame(height: 44)
                .foregroundColor(.black)
                .background(Color(.systemGray6))
            }
        }
    }
}
