//
//  SwipeItemView.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/20.
//

import SwiftUI

struct SwipeItemView<Content: View, Right: View>: View {
    var content: () -> Content
    var right: () -> Right
    var itemHeight: CGFloat
    
    init(content: @escaping () -> Content, right: @escaping () -> Right, itemHeight: CGFloat) {
        self.content = content
        self.right = right
        self.itemHeight = itemHeight
    }
    
    @State var hoffSet: CGFloat = 0
    @State var anchor: CGFloat = 0
    
    let screenWidth = UIScreen.main.bounds.width
    var anchorWidth: CGFloat { screenWidth / 3}
    var swipeTreshold: CGFloat { screenWidth / 15 }
    
    @State var rightPast = false
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                withAnimation {
                    hoffSet = anchor + value.translation.width
                    
                    if abs(hoffSet) > anchorWidth {
                        if rightPast {
                            hoffSet = -anchorWidth
                        }
                    }
                    
                    if anchor < 0 {
                        rightPast = hoffSet < -anchorWidth + swipeTreshold
                    } else {
                        rightPast = hoffSet < -swipeTreshold
                    }
                }
            }
            .onEnded { value in
                withAnimation {
                    if rightPast {
                        anchor = -anchorWidth
                    } else {
                        anchor = 0
                    }
                    hoffSet = anchor
        
                }
                
            }
    }
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 0) {
                content()
                    .frame(width: geo.size.width + 20)
                right()
                    .frame(width: anchorWidth)
                    .zIndex(1)
                    .clipped()
            }
            .offset(x: hoffSet)
            .frame(maxHeight: 84)
            .contentShape(RoundedRectangle(cornerRadius: 12))
            .gesture(drag)
            .clipped()
            
        }
    }
}
