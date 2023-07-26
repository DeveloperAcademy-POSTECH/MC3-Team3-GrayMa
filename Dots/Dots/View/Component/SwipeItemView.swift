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
    @Binding var resetSwipe: Bool
    @Binding var trashPresented: Bool
    
    init(content: @escaping () -> Content, right: @escaping () -> Right, itemHeight: CGFloat, resetSwipe: Binding<Bool>, trashPresented: Binding<Bool>) {
        self.content = content
        self.right = right
        self.itemHeight = itemHeight
        self._resetSwipe = resetSwipe
        self._trashPresented = trashPresented
    }
    
    @State var hoffSet: CGFloat = 0
    @State var anchor: CGFloat = 0
    
    let screenWidth = UIScreen.main.bounds.width
    var anchorWidth: CGFloat { screenWidth / 3}
    var swipeThreshold: CGFloat { screenWidth / 20 }
    
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
                        rightPast = hoffSet < -anchorWidth + swipeThreshold
                    } else {
                        rightPast = hoffSet < -swipeThreshold
                    }
                }
            }
            .onEnded { value in
                withAnimation {
                    if rightPast {
                        anchor = -anchorWidth
                        trashPresented = true
                    } else {
                        anchor = 0
                        trashPresented = false
                    }
                    hoffSet = anchor}
            }
    }
    
    var body: some View {
        GeometryReader { geo in
            HStack() {
                content()
                    .frame(width: geo.size.width + 20)
                    .contentShape(Rectangle())
                    .buttonStyle(.borderless)
                    .highPriorityGesture(drag)
                right()
                    .frame(width: anchorWidth)
                    .zIndex(1)
                    .clipped()
                    .buttonStyle(.borderless)
            }
            .offset(x: hoffSet)
            .frame(maxHeight: 84)
            .contentShape(Rectangle())
            .gesture(drag)
            .onChange(of: resetSwipe) { newValue in
                if newValue {
                    withAnimation {
                        anchor = 0
                        hoffSet = 0
                        resetSwipe = false
                    }
                }
            }
        }
    }
}
