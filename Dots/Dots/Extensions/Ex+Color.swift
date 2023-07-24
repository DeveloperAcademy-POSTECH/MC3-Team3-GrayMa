//
//  Ex+Color.swift
//  Dots
//
//  Created by 정승균 on 2023/07/24.
//

import Foundation
import SwiftUI

extension Color {
    
    /// Assets에 추가한 색상 사용하기 편하도록 extenstion 구현
    /// ```
    /// Ex)
    /// Text("Red Color")
    ///     .foregroundColor(Color.theme.alertRed)
    /// ```
    static let theme = ColorTheme()
    
    struct ColorTheme {
        static let alertGreen = Color("alertGreen")
        static let alertRed = Color("alertRed")
        static let primary = Color("primaryColor")
        static let sub = Color("subColor")
        static let fontBlack = Color("fontBlack")
        static let fontGray = Color("fontGray")
        static let fontWhite = Color("fontWhite")
    }
}
