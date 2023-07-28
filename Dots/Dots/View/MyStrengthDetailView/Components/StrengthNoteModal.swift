//
//  StrengthNoteModal.swift
//  Dots
//
//  Created by Jae Ho Yoon on 7/20/23.
//
// 새로운 노트 작성
import SwiftUI

struct StrengthNoteModal: View, KRDate {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var dotsModel: DotsModel
    @FocusState private var isTextEditorFocused: Bool
    @State private var textFieldContent: String = ""
    @State private var date: Date = Date()
    @State private var isError: Bool = false
    @State private var dragDisabled: Bool = false
    @State private var dragIndicator: Visibility = .visible
    
    let myStrength: MyStrengthEntity
    let placeholder = "어떤 것을 배웠나요? 자유롭게 기록해주세요."
    
    var body: some View {
        VStack {
            noteModalTopBar
            textEditor
            Spacer()
        }
        .onChange(of: textFieldContent) { newValue in
            if newValue.isEmpty { viewMode() }
        }
        .padding()
        .padding(.top, 10)
        .presentationDragIndicator(dragIndicator)
        .interactiveDismissDisabled(dragDisabled)
    }
}

extension StrengthNoteModal {
    private var noteModalTopBar: some View {
        ZStack {
            HStack {
                // 좌측 버튼
                Button {
                    if textFieldContent.isEmpty {
                        presentation.wrappedValue.dismiss()
                    } else {
                        hideKeyboard()
                        isError = true
                    }
                } label: {
                    Text("취소")
                }
                .alert("작성 중인 내용을 저장하지 않고 나가시겠습니까?", isPresented: $isError) {
                    Button("아니요", role: .cancel) { }
                    Button("네", role: .destructive) { presentation.wrappedValue.dismiss() }
                }
                
                Spacer()
                
                // 우측 버튼
                Button {
                    // 저장 기능
                    if textFieldContent.isEmpty {
                        presentation.wrappedValue.dismiss()
                    } else {
                        dotsModel.addMyNote(date: date, content: textFieldContent, strength: myStrength)
                        presentation.wrappedValue.dismiss()
                    }
                } label: {
                    Text("저장")
                }
                .opacity(textFieldContent.isEmpty ? 0 : 1)
            }
            
            // 중앙 날짜 + 누르면 키보드 내려감
            Button {
                hideKeyboard()
            } label: {
                Text("\(date, formatter: dateFormatter)")
                    .modifier(semiBoldBody(colorName: .theme.gray5Dark))
            }
        }
        .frame(height: 40, alignment: .top)
    }
}

extension StrengthNoteModal {
    private var textEditor: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $textFieldContent)
                .modifier(regularCallout(colorName: .theme.gray5Dark))
                .focused($isTextEditorFocused)
            
            if textFieldContent.isEmpty && !isTextEditorFocused {
                Text(placeholder)
                    .modifier(regularCallout(colorName: .theme.gray))
                    .padding(.leading, 5)
                    .padding(.top, 8)
            }
        }
        .onTapGesture {
            editMode()
            isTextEditorFocused = true // placeholder 텍스트를 눌렀을 때 대비
        }
    }
}

extension StrengthNoteModal {
    func viewMode() {
        dragDisabled = false
        dragIndicator = .visible
    }
    
    func editMode() {
        dragDisabled = true
        dragIndicator = .hidden
    }
    
    // alert 사라질때 키보드 올라왔다 내려가는 버그 FIX
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
