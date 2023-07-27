//
//  StrengthLevelImage.swift
//  Dots
//
//  Created by 정승균 on 2023/07/27.
//

import Foundation

enum StrengthLevelImage: String, CaseIterable {
    case weakDot
    case moderateDot
    case strongDot
    
    var ballSize: CGFloat {
        switch self {
        case .weakDot:
            return 100
        case .moderateDot:
            return 110
        case .strongDot:
            return 120
        }
    }
    var size: CGFloat { return 76 }
    var sizeSmall: CGFloat { return 36 }
}
