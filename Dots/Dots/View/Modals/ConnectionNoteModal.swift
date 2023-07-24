//
//  ConnectionNoteModal.swift
//  Dots
//
//  Created by Chaeeun Shin on 2023/07/23.
//

import SwiftUI

struct ConnectionNoteModal: View {
    @Environment(\.dismiss) private var dismiss
    @State private var date: Date = Date()
    @State private var textFieldContent: String = ""
    @State private var showKeyboardToolbar: Bool = false
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일"
        return formatter
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("취소")
                }
                
                Spacer()
                
                Text("\(date, formatter: dateFormatter)")
                    .font(.headline)
                
                Spacer()
                
                Button {
//                    dotsModel.addMyNote(date: date, content: textFieldContent, strength: myStrength)
                    dismiss()
                } label: {
                    Text("저장")
                }
            }
            .frame(height: 44)
            
            TextField("상대에 대해 남기고 싶은 점을 자유롭게 기록해주세요.", text: $textFieldContent, axis: .vertical)
                .foregroundColor(textFieldContent.isEmpty ? .gray : .primary)
            Spacer()
        }
        .padding()
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
            self.showKeyboardToolbar = true
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            self.showKeyboardToolbar = false
        }
        .overlay(KeyboardToolbar(showKeyboardToolbar: $showKeyboardToolbar, date: $date), alignment: .bottom)
        .presentationDragIndicator(.visible)

    }
}
