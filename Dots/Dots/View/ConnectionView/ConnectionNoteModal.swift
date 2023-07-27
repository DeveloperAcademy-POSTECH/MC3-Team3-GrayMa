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
    @FocusState private var isTextEditorFocused: Bool
    @State private var date: Date = Date()
    @State private var textFieldContent: String = ""
    @State private var isError = false
    
    let connection: NetworkingPersonEntity
    
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
                        isError = true
                    }) {
                        HStack {
                            Text("취소")
                        }
                    }
                    .alert("작성 중인 내용을 저장하지 않고 나가시겠습니까?", isPresented: $isError) {
                        Button("아니요", role: .cancel) { }
                        Button("네", role: .destructive) { dismiss() }
                    }
                    Spacer()
                    
                    Button(action: {
                        dotsModel.addConnectionNote(date: date, content: textFieldContent, connection: connection)
                        dismiss()
                    }) {
                        Text("저장")
                    }
                }
                Text("\(date, formatter: dateFormatter)")
                    .modifier(semiBoldBody(colorName: .theme.gray5Dark))
            }
            .frame(height: 40, alignment: .top)
            
            let placeholder: String = "상대에 대해 남기고 싶은 점을 자유롭게 기록해주세요."
            ZStack(alignment: .topLeading) {
                TextEditor(text: $textFieldContent)
                    .modifier(regularCallout(colorName: .theme.gray5Dark))
                    .focused($isTextEditorFocused)
                if textFieldContent.isEmpty && !isTextEditorFocused {
                    Text(placeholder)
                        .modifier(regularCallout(colorName: .theme.gray))
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
        .padding(.top, 10)
        .presentationDragIndicator(.visible)
    }
}
