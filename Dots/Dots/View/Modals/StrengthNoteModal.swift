//
//  StrengthNoteModal.swift
//  Dots
//
//  Created by Jae Ho Yoon on 7/20/23.
//

import SwiftUI

struct StrengthNoteModal: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var dotsModel: DotsModel
    @State private var textFieldContent: String = ""
    @State private var date: Date = Date()
    @State private var showKeyboardToolbar: Bool = false
    let myStrength: MyStrengthEntity
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일"
        return formatter
    }

    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button(action: {
                        presentation.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.backward")
                            Text("목록")
                        }
                    }
                    Spacer()
                    
                    Button(action: {
                        // 저장 기능
                        dotsModel.addMyNote(date: date, content: textFieldContent, strength: myStrength)
                        presentation.wrappedValue.dismiss()
                    }) {
                        Text("저장")
                    }
                }
                Text("\(date, formatter: dateFormatter)")
                    .font(.headline)
            }
            .frame(height: 40, alignment: .top)
            
            
            TextField("어떤 것을 배웠나요? 자유롭게 기록해주세요.", text: $textFieldContent)
                .foregroundColor(textFieldContent.isEmpty ? .gray : .primary)
            
            Spacer()
        }
        .padding()
        .padding(.top, 10)
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
            self.showKeyboardToolbar = true
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            self.showKeyboardToolbar = false
        }
        .overlay(KeyboardToolbar(showKeyboardToolbar: $showKeyboardToolbar), alignment: .bottom)
        .presentationDragIndicator(.visible)
    }
}
