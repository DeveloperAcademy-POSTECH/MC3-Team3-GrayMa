//
//  OpenNoteModal.swift
//  Dots
//
//  Created by Jae Ho Yoon on 7/28/23.
//

import SwiftUI

struct OpenNoteViewModal: View, KRDate {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var dotsModel: DotsModel
    @FocusState private var isTextEditorFocused: Bool
    
    @State var textFieldContent: String
    @State var date: Date
    @State private var isError: Bool = false
    @State private var dragDisabled: Bool = false
    @State private var dragIndicator: Visibility = .visible
    @State private var notEdited: Bool = true
    @State private var textOriginal: String = ""
    
    let id: UUID
    let entity: NSObject
    let placeholder: String
    
    var body: some View {
        VStack {
            noteModalTopBar
            textEditor
            Spacer()
        }
        .onAppear {
            textOriginal = textFieldContent
        }
        .onChange(of: textFieldContent) { newValue in
            if newValue == textOriginal {
                viewMode()
                notEdited = true
            } else {
                editMode()
                notEdited = false
            }
        }
        .padding()
        .padding(.top, 10)
        .presentationDragIndicator(dragIndicator)
        .interactiveDismissDisabled(dragDisabled)
    }
}

extension OpenNoteViewModal {
    private var noteModalTopBar: some View {
        ZStack {
            HStack {
                // 좌측 버튼
                Button {
                    if notEdited {
                        presentation.wrappedValue.dismiss()
                    } else {
                        hideKeyboard()
                        isError = true
                    }
                } label: {
                    Text("취소")
                }
                .alert("작성 중인 내용을\n저장하지 않고 나가시겠습니까?", isPresented: $isError) {
                    Button("아니요", role: .cancel) { }
                    Button("네", role: .destructive) { presentation.wrappedValue.dismiss() }
                }
                .opacity(notEdited ? 0 : 1)
                
                Spacer()
                
                // 우측 버튼
                if notEdited {
                    Button {
                        presentation.wrappedValue.dismiss()
                    } label: {
                        Text("확인")
                    }
                } else {
                    Button {
                        dotsModel.updateNote(id: id, date: date, content: textFieldContent, entity: entity)
                        presentation.wrappedValue.dismiss()
                    } label: {
                        Text("저장")
                    }
                }
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

extension OpenNoteViewModal {
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

extension OpenNoteViewModal {
    func viewMode() {
        dragDisabled = false
        dragIndicator = .visible
    }
    
    func editMode() {
        dragDisabled = true
        dragIndicator = .hidden
        isTextEditorFocused = true
    }
    
    // alert 사라질때 키보드 올라왔다 내려가는 버그 FIX
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
