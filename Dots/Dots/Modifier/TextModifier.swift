//
//  TextModifier.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/18.
//

import SwiftUI

struct regularLargeTitle: ViewModifier {
    var colorName: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 34))
            .fontWeight(.regular)
            .foregroundColor(colorName)
    }
    
}

struct boldLargeTitle: ViewModifier {
    var colorName: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 34))
            .fontWeight(.bold)
            .foregroundColor(colorName)
    }
    
}

struct regularTitle1: ViewModifier{
    var colorName: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 28))
            .fontWeight(.regular)
            .foregroundColor(colorName)
    }
}

struct boldTitle1: ViewModifier{
    var colorName: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 28))
            .fontWeight(.bold)
            .foregroundColor(colorName)
    }
}

struct regularTitle2: ViewModifier{
    var colorName: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 22))
            .fontWeight(.regular)
            .foregroundColor(colorName)
    }
}

struct boldTitle2: ViewModifier{
    var colorName: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 22))
            .fontWeight(.bold)
            .foregroundColor(colorName)
    }
}

struct regularTitle3: ViewModifier{
    var colorName: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20))
            .fontWeight(.regular)
            .foregroundColor(colorName)
    }
}

struct semiBoldTitle3: ViewModifier{
    var colorName: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20))
            .fontWeight(.semibold)
            .foregroundColor(colorName)
    }
}

struct regularBody: ViewModifier{
    var colorName: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 17))
            .fontWeight(.regular)
            .foregroundColor(colorName)
    }
}

struct semiBoldBody: ViewModifier{
    var colorName: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 17))
            .fontWeight(.semibold)
            .foregroundColor(colorName)
    }
}

struct regularCallout: ViewModifier{
    var colorName: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16))
            .fontWeight(.regular)
            .foregroundColor(colorName)
    }
}

struct semiBoldCallout: ViewModifier{
    var colorName: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16))
            .fontWeight(.semibold)
            .foregroundColor(colorName)
    }
}

struct regularSubHeadLine: ViewModifier{
    var colorName: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 15))
            .fontWeight(.regular)
            .foregroundColor(colorName)
    }
}

struct semiBoldSubHeadLine: ViewModifier{
    var colorName: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 15))
            .fontWeight(.semibold)
            .foregroundColor(colorName)
    }
}

struct regularFootNote: ViewModifier{
    var colorName: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 13))
            .fontWeight(.regular)
            .foregroundColor(colorName)
    }
}

struct semiBoldFootNote: ViewModifier{
    var colorName: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 13))
            .fontWeight(.semibold)
            .foregroundColor(colorName)
    }
}

struct regularCaption1: ViewModifier{
    var colorName: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 12))
            .fontWeight(.regular)
            .foregroundColor(colorName)
    }
}

struct mediumCaption1: ViewModifier{
    var colorName: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 12))
            .fontWeight(.medium)
            .foregroundColor(colorName)
    }
}

struct regularCaption2: ViewModifier{
    var colorName: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 11))
            .fontWeight(.regular)
            .foregroundColor(colorName)
    }
}

struct semiBoldCaption2: ViewModifier{
    var colorName: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 11))
            .fontWeight(.semibold)
            .foregroundColor(colorName)
    }
}

struct contactsStrength: ViewModifier {
    var colorName: Color
    
    func body(content: Content) -> some View {
        RoundedRectangle(cornerRadius: 4)
            .frame(width: 64,height: 24)
            .foregroundColor(colorName)
            .overlay() {
                content
                    .modifier(regularCaption1(colorName: Fontcolor.fontBlack.colorName))
            }

    }
}

enum Fontcolor{
    case fontBlack
    case fontGray
    case fontWhite
    
    var colorName: Color{
        switch self{
        case.fontBlack:
            return Color("FontBlack")
        case .fontGray:
            return Color("FontGray")
        case .fontWhite:
            return Color("FontWhite")
        }
    }
}












