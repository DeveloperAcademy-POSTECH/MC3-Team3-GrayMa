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
        // Alert
        let alertGreen = Color("alertGreen")
        let alertRed = Color("alertRed")
        
        // Brand
        let primary = Color("primary")
        let secondary = Color("secondary")
        let disabled = Color("disabled")
        let text = Color("text")
        
        // GrayScale
        let bgMain = Color("bgMain")
        let bgPrimary = Color("bgPrimary")
        let bgSecondary = Color("bgSecondary")
        let gray = Color("gray")
        let gray5 = Color("gray5")
        let gray5Dark = Color("gray5Dark")
    }
}
