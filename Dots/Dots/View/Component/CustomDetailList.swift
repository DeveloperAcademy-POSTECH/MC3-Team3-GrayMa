//
//  CustomDetailList.swift
//  Dots
//
//  Created by Jae Ho Yoon on 7/19/23.
//

import SwiftUI

struct CustomDetailList: View {
    var entity: MyStrengthNoteEntity
    let dateFormatter = DateFormatter()
    var dateText: String {
        dateFormatter.dateFormat = "MMM d yyyy, h:mm a"
        return dateFormatter.string(from: entity.date ?? Date())
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 62)
            .padding(.horizontal, 16)
            .overlay()
        {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(entity.content ?? "제목")
                        .modifier(semiBoldTitle3(colorName: .black))
                    HStack {
                        Group {
                            Text(dateText)
                            Text(entity.content ?? "내용")
                        }
                        .modifier(regularSubHeadLine(colorName: .gray))
                    }
                }
                .padding(.leading, 45)
                Spacer()
            }
        }
    }
}
