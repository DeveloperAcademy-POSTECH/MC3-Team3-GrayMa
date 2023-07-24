//
//  SearchFilterListRow.swift
//  Dots
//
//  Created by 정승균 on 2023/07/22.
//

import SwiftUI

struct SearchFilterListRow: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 40)
            .stroke(Color.gray, lineWidth: 0.5)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .overlay {
                HStack {
                    Image(systemName: "house.fill")
                        .scaledToFit()
                        .frame(width: 29)
                        .padding(.trailing, 14)
                        .padding(.leading, 20)
                    Text("회사")
                        .modifier(regularSubHeadLine(colorName: .black))
                    Spacer()
                    
                    Text("모두")
                        .modifier(regularSubHeadLine(colorName: .gray))
                        .padding(.trailing, 30)
                }
            }
    }
}

struct SearchFilterListRow_Previews: PreviewProvider {
    static var previews: some View {
        SearchFilterListRow()
            .previewLayout(.sizeThatFits)
    }
}
