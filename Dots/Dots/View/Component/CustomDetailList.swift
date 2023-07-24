//
//  CustomDetailList.swift
//  Dots
//
//  Created by Jae Ho Yoon on 7/19/23.
//

import SwiftUI

struct CustomDetailList: View {
    @State var showNoteViewModal = false
    @ObservedObject var noteEntity: MyStrengthNoteEntity
    
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
        Button(action: {
            self.showNoteViewModal = true
        }, label: {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 62)
                .padding(.horizontal, 16)
                .overlay()
            {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(titleText)
                            .modifier(semiBoldTitle3(colorName: .black))
                        HStack {
                            Group {
                                Text(dateText)
                                Text(subtitleText)
                            }
                            .modifier(regularSubHeadLine(colorName: .gray))
                        }
                    }
                    .padding(.leading, 45)
                    Spacer()
                }
            }
        })
        
        // 기존 강점노트 클릭시 나오는 Modal
        .sheet(isPresented: $showNoteViewModal){
            StrengthNoteViewModal(id: noteEntity.myStrengthNoteID!, textFieldContent: noteEntity.content ?? "", date: noteEntity.date!)
        }
    }
}
