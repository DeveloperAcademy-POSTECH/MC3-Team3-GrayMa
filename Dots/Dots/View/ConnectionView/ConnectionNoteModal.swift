//
//  ConnectionNoteModal.swift
//  Dots
//
//  Created by Chaeeun Shin on 2023/07/23.
//

import SwiftUI

struct ConnectionNoteModal: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var dotsModel: DotsModel
    @State private var date: Date = Date()
    @State private var textFieldContent: String = ""
    @State private var showKeyboardToolbar: Bool = false
    @State private var pushCancel = false
    let connection: NetworkingPersonEntity
    
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
                    pushCancel.toggle()
                } label: {
                    Text("취소")
                }
                .alert("작성 중인 내용을 저장하지 않고 나가시겠습니까?", isPresented: $pushCancel) {
                    Button("아니요", role: .cancel) { }
                    Button("네", role: .destructive) { dismiss() }
                }
                
                Spacer()
                
                Text("\(date, formatter: dateFormatter)")
                    .modifier(semiBoldBody(colorName: Color.theme.gray5Dark))
                
                Spacer()
                
                Button {
                    dotsModel.addConnectionNote(date: date, content: textFieldContent, connection: connection)
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
