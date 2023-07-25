//
//  ConnectionNoteList.swift
//  Dots
//
//  Created by Chaeeun Shin on 2023/07/24.
//

import SwiftUI

struct ConnectionNoteList: View {
    @ObservedObject var noteEntity: NetworkingNoteEntity
    
    @State var showNoteViewModal = false

    var titleText: String {
        guard let content = noteEntity.content else { return "" }
        
        let splitContent = content.split(separator: "\n")
        return String(splitContent.first ?? "제목")
    }
    var subtitleText: String {
        guard let content = noteEntity.content else { return "" }
        
        let splitContent = content.split(separator: "\n")
        return splitContent.count > 1 ? String(splitContent[1]) : "내용"
    }
    
    let calendar = Calendar.current
    var dateText: String {
        let currentDate = Date()
        let startOfToday = calendar.startOfDay(for: currentDate)
        let startOfYesterday = calendar.startOfDay(for: calendar.date(byAdding: .day, value: -1, to: currentDate) ?? currentDate)
        
        if let date = calendar.date(byAdding: .minute, value: 1, to: noteEntity.date!), date >= startOfToday {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.dateFormat = "a h:mm"
            
            return dateFormatter.string(from: noteEntity.date!)
        } else if let date = calendar.date(byAdding: .day, value: 1, to: noteEntity.date!), date >= startOfYesterday {
            return "어제"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy. MM. d"
            return dateFormatter.string(from: noteEntity.date!)
        }
    }
    
    var body: some View {
        Button {
            self.showNoteViewModal = true
        } label: {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 62)
                .overlay(
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(titleText)
                                .modifier(semiBoldTitle3(colorName: Color.theme.gray5Dark))
                            HStack {
                                Text(dateText)
                                Text(subtitleText)
                            }
                            .modifier(regularSubHeadLine(colorName: Color.theme.gray))
                        }
                        .padding(.leading, 25)
                        Spacer()
                    }
                )
        }
        
        // 기존 강점노트 클릭시 나오는 Modal
        .sheet(isPresented: $showNoteViewModal){
            ConnectionNoteViewModal(id: noteEntity.networkingNoteID!, date: noteEntity.date!, textFieldContent: noteEntity.content ?? "")
        }
    }
}
