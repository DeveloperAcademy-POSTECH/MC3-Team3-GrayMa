//
//  StrengthNoteList.swift
//  Dots
//
//  Created by Jae Ho Yoon on 7/19/23.
//

import SwiftUI

struct StrengthNoteList: View {
    @EnvironmentObject var dotsModel: DotsModel
    @ObservedObject var noteEntity: MyStrengthNoteEntity
    
    @State private var showNoteViewModal = false
    @State private var isError: Bool = false
    @State private var resetSwipe: Bool = false
    @State private var trashPresented: Bool = false
    
    var titleText: String {
        guard let content = noteEntity.content else { return "" }
        
        let splitContent = content.split(separator: "\n")
        return String(splitContent.first ?? "제목 없음")
    }
    var subtitleText: String {
        guard let content = noteEntity.content else { return "" }
        
        let splitContent = content.split(separator: "\n")
        return splitContent.count > 1 ? String(splitContent[1]) : "내용 없음"
    }
    
    let calendar = Calendar.current
    var dateText: String {
        let currentDate = Date()
        let startOfToday = calendar.startOfDay(for: currentDate)
        let startOfYesterday = calendar.startOfDay(for: calendar.date(byAdding: .day, value: -1, to: currentDate) ?? currentDate)
        
        if let date = calendar.date(byAdding: .minute, value: 1, to: noteEntity.date ?? Date()), date >= startOfToday {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.dateFormat = "a h:mm"
            
            return dateFormatter.string(from: noteEntity.date ?? Date())
        } else if let date = calendar.date(byAdding: .day, value: 1, to: noteEntity.date!), date >= startOfYesterday {
            return "어제"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy. MM. d"
            return dateFormatter.string(from: noteEntity.date!)
        }
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundColor(.white)
            .frame(height: 62)
            .overlay() {
                SwipeItemView(content: {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(titleText)
                                .modifier(semiBoldTitle3(colorName: .theme.gray5Dark))
                            HStack {
                                Group {
                                    Text(dateText)
                                    Text(subtitleText)
                                }
                                .modifier(regularSubHeadLine(colorName: .theme.gray5Dark))
                            }
                        }
                        .padding(.leading, 29)
                        Spacer()
                    }
                    //                    .onTapGesture { self.showNoteViewModal = true }
                }, right: {
                    HStack(spacing: 0) {
                        Button {
                            isError = true
                        } label: {
                            Rectangle()
                                .fill(.red)
                                .cornerRadius(12, corners: .topRight)
                                .cornerRadius(12, corners: .bottomRight)
                                .overlay(){
                                    Image(systemName: "trash.fill")
                                        .font(.system(size: 17))
                                        .foregroundColor(.white)
                                }
                        }
                        .alert("이 기록을 삭제하겠습니까?", isPresented: $isError, actions: {
                            Button("취소", role: .cancel) { resetSwipe = true }
                            Button("삭제", role: .destructive) { dotsModel.deleteNote(entity: noteEntity) }
                        }, message: {
                            Text("이 기록이 삭제됩니다.")
                        })
                    }
                }, itemHeight: 62, resetSwipe: $resetSwipe, trashPresented: $trashPresented)
            }
            .cornerRadius(12, corners: .allCorners)
            .frame(height: 62)
        
        // 기존 강점노트 클릭시 나오는 Modal
            .sheet(isPresented: $showNoteViewModal){
                OpenNoteViewModal(textFieldContent: noteEntity.content ?? "", date: noteEntity.date!, id: noteEntity.myStrengthNoteID!, entity: noteEntity, placeholder: "어떤 것을 배웠나요? 자유롭게 기록해주세요.")
            }
            .onTapGesture {
                if trashPresented {
                    trashPresented = false
                    resetSwipe = true
                } else {
                    self.showNoteViewModal = true
                }
            }
    }
}
