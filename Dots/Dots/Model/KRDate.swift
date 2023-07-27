//
//  KRDate.swift
//  Dots
//
//  Created by Jae Ho Yoon on 7/28/23.
//

import Foundation

protocol KRDate {
    var dateFormatter: DateFormatter { get }
}

extension KRDate {
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일"
        return formatter
    }
}
