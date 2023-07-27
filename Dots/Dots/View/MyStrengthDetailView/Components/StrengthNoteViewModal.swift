//
//  StrengthNoteViewModal.swift
//  Dots
//
//  Created by Jae Ho Yoon on 7/20/23.
//
// 기존 노트 열람
import SwiftUI

struct StrengthNoteViewModal: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var dotsModel: DotsModel
    @FocusState private var isTextEditorFocused: Bool
    let id: UUID
    @State var textFieldContent: String
    @State var date: Date
    @State private var isError: Bool = false
    
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
                        Button("네", role: .destructive) { presentation.wrappedValue.dismiss() }
                    }
                    Spacer()
                    
                    Button(action: {
                        // 수정 기능
                        dotsModel.updateMyNote(id: id, date: date, content: textFieldContent)
                        presentation.wrappedValue.dismiss()
                    }) {
                        Text("저장")
                    }
                }
                Text("\(date, formatter: dateFormatter)")
                    .modifier(semiBoldBody(colorName: .theme.gray5Dark))
            }
            .frame(height: 40, alignment: .top)
            
            let placeholder: String = "어떤 것을 배웠나요? 자유롭게 기록해주세요."
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
