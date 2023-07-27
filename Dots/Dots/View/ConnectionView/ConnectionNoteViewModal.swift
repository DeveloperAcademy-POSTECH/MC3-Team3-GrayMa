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
    @State var date: Date
    @State var textFieldContent: String
    @State private var pushCancel = false
    

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일"
        return formatter
    }
    
    var body: some View {
        VStack {
            HStack {
                if isTextEditorFocused {
                    Button {
                        pushCancel.toggle()
                    } label: {
                        Text("취소")
                    }
                    .alert("수정 중인 내용을 저장하지 않고 나가시겠습니까?", isPresented: $pushCancel) {
                        Button("아니요", role: .cancel) { }
                        Button("네", role: .destructive) { dismiss() }
                    }
                } else {
                    Text("취소")
                        .opacity(0)
                }
                
                Spacer()
                
                Text("\(date, formatter: dateFormatter)")
                    .modifier(semiBoldBody(colorName: Color.theme.gray5Dark))
                
                Spacer()
                
                if isTextEditorFocused {
                    Button {
                        dotsModel.updateConnectionNote(id: id, date: date, content: textFieldContent)
                        dismiss()
                    } label: {
                        Text("저장")
                    }
                } else {
                    Button {
                        dismiss()
                    } label: {
                        Text("확인")
                    }
                }
            }
            .frame(height: 44)
            
            let placeholder: String = "상대에 대해 남기고 싶은 점을 자유롭게 기록해주세요."
            ZStack(alignment: .topLeading) {
                TextEditor(text: $textFieldContent)
                    .modifier(regularCallout(colorName: Color.theme.gray5Dark))
                    .focused($isTextEditorFocused)
                if textFieldContent.isEmpty && !isTextEditorFocused {
                    Text(placeholder)
                        .modifier(regularCallout(colorName: Color.theme.gray))
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
        .presentationDragIndicator(.visible)
    }
}
