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
    
    static func colorWithOpacity(color: Color, opacity: Double) -> Color {
        return color.opacity(opacity)
    }
    
    struct ColorTheme {
        let alertGreen = Color("alertGreen")
        let alertRed = Color("alertRed")
        let primary = Color("primaryColor")
        let sub = Color("subColor")
        let fontBlack = Color("fontBlack")
        let fontGray = Color("fontGray")
        let fontWhite = Color("fontWhite")
        let bgPrimary = Color("bgPrimary")
        let lightBg = Color("lightBg")
        let secondaryBg = Color("secondaryBg")
        let stroke = Color("stroke")
        let secondaryLabel = Color("secondaryLabel")
    }
}
