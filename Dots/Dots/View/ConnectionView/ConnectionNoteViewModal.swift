//
//  ConnectionNoteViewModal.swift
//  Dots
//
//  Created by Chaeeun Shin on 2023/07/24.
//

import SwiftUI

struct ConnectionNoteViewModal: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var dotsModel: DotsModel
    @FocusState private var isTextEditorFocused: Bool
    let id: UUID
    @State var textFieldContent: String
    @State var date: Date
    @State private var showKeyboardToolbar: Bool = false

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일"
        return formatter
    }
    //테스트
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
                    dotsModel.updateConnectionNote(id: id, date: date, content: textFieldContent)
                    dismiss()
                } label: {
                    Text("저장")
                }
            }
            .frame(height: 44)
            
            let placeholder: String = "상대에 대해 남기고 싶은 점을 자유롭게 기록해주세요."
            ZStack(alignment: .topLeading) {
                TextEditor(text: $textFieldContent)
                    .modifier(regularCallout(colorName: Fontcolor.fontBlack.colorName))
                    .focused($isTextEditorFocused)
                if textFieldContent.isEmpty && !isTextEditorFocused {
                    Text(placeholder)
                        .modifier(regularCallout(colorName: Fontcolor.fontGray.colorName))
                        .foregroundColor(.gray)
                        .padding(.leading, 5)
                        .padding(.top, 8)
                        .onTapGesture {
                            isTextEditorFocused = true
                        }
                }
            }
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
