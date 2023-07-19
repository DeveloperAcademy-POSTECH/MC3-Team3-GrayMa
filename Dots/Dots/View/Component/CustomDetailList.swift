//
//  CustomDetailList.swift
//  Dots
//
//  Created by Jae Ho Yoon on 7/19/23.
//

import SwiftUI

struct DummyNoteEntity: Hashable {
    var content: String
    var date: Date
}

var dummyNoteData: [DummyNoteEntity] = [
    DummyNoteEntity(content: "Grid System\nContents", date: Date().addingTimeInterval(-1000)),
    DummyNoteEntity(content: "First line\nSecond line", date: Date().addingTimeInterval(-70000)),
    DummyNoteEntity(content: "Database Study", date: Date().addingTimeInterval(-250000))
]

struct CustomDetailList: View {
    var entity: DummyNoteEntity
    
    var titleText: String {
        let splitContent = entity.content.split(separator: "\n")
        return String(splitContent.first ?? "제목")
    }
    var subtitleText: String {
        let splitContent = entity.content.split(separator: "\n")
        return splitContent.count > 1 ? String(splitContent[1]) : "내용"
    }
    
    let calendar = Calendar.current
    var dateText: String {
        let currentDate = Date()
        let startOfToday = calendar.startOfDay(for: currentDate)
        let startOfYesterday = calendar.startOfDay(for: calendar.date(byAdding: .day, value: -1, to: currentDate) ?? currentDate)

        if let date = calendar.date(byAdding: .minute, value: 1, to: entity.date), date >= startOfToday {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.dateFormat = "a h:mm"
            return dateFormatter.string(from: entity.date)
        } else if let date = calendar.date(byAdding: .day, value: 1, to: entity.date), date >= startOfYesterday {
            return "어제"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy. MM. d"
            return dateFormatter.string(from: entity.date)
        }
    }
    
    var body: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
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
    }
}
