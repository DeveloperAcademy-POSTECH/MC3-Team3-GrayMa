//
//  MetaballAnimation.swift
//  Dots
//
//  Created by 정승균 on 2023/07/25.
//

import SwiftUI

struct MetaballAnimation: View {
    @EnvironmentObject var dotsModel: DotsModel
    @State var dragOffset: CGSize = .zero
    @State var startAnimation: Bool = true
    @Binding var isTapped: Bool
    
    let myStrength: [MyStrengthEntity]
    
    var body: some View {
        VStack {
            TimelineView(.animation(minimumInterval: 3.6, paused: false)) { _ in
                let offset: [Int : CGSize] = setupRandomOffset()
                
                ZStack {
                    Rectangle()
                        .fill(.linearGradient(stops: [
                            Gradient.Stop(color: Color(red: 0.87, green: 0.29, blue: 0.28), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.96, green: 0.93, blue: 0.86), location: 1.00),
                        ],
                                              startPoint: UnitPoint(x: 1.06, y: 0.94),
                                              endPoint: UnitPoint(x: 0.16, y: 0.09)))
                        .mask {
                            Canvas { context, size in
                                context.addFilter(.alphaThreshold(min: 0.5, color: .theme.secondary))
                                context.addFilter(.blur(radius: 10))
                                context.drawLayer { ctx in
                                    for index in 0...myStrength.count - 1 {
                                        if let resolvedView = context.resolveSymbol(id: index) {
                                            ctx.draw(resolvedView, at: CGPoint(x: size.width / 2, y: size.height / 2))
                                        }
                                    }
                                }
                            } symbols: {
                                ForEach(0...myStrength.count - 1, id: \.self) { index in
                                    ClubbedRoundedRectangle(offset: offset[index] ?? .zero, ballLevel: StrengthLevelImage.allCases[Int(myStrength[index].strengthLevel)])
                                        .tag(index)
                                }
                            }
                        }
                    
                    Canvas { context, size in
                        context.drawLayer { ctx in
                            for index in 0...myStrength.count - 1 {
                                if let resolvedView = context.resolveSymbol(id: index) {
                                    ctx.draw(resolvedView, at: CGPoint(x: size.width / 2, y: size.height / 2))
                                }
                            }
                        }
                    } symbols: {
                        ForEach(0...myStrength.count - 1, id: \.self) { index in
                            Name(offset: offset[index] ?? .zero, name: myStrength[index].ownStrength?.strengthName)
                                .tag(index)
                        }
                    }
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                startAnimation.toggle()
            }
        }
    }
    
    func setupRandomOffset() -> [Int : CGSize] {
        var offsetList: [Int : CGSize] = [:]
        
        for i in 0...2 {
            offsetList[i] = CGSize(width: .random(in: -100...100), height: .random(in: -120...120))
        }
        
        return offsetList
    }
    
    @ViewBuilder
    func Name(offset: CGSize, name: String?) -> some View {
        Text(name ?? "이거")
            .modifier(regularSubHeadLine(colorName: Color.theme.bgPrimary))
            .offset(offset)
            .frame(maxWidth: 100)
            .lineLimit(2)
            .animation(.easeInOut(duration: 3.6), value: offset)
            .multilineTextAlignment(.center)
    }
    
    @ViewBuilder
    func ClubbedRoundedRectangle(offset: CGSize, ballLevel: StrengthLevelImage) -> some View {
        Circle()
            .fill(.linearGradient(stops: [
                                    Gradient.Stop(color: Color(red: 0.87, green: 0.29, blue: 0.28), location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.96, green: 0.93, blue: 0.86), location: 1.00),
                                ],
                                                      startPoint: UnitPoint(x: 1.06, y: 0.94),
                                                      endPoint: UnitPoint(x: 0.16, y: 0.09)))
            .frame(width: ballLevel.ballSize * 1.4, height: ballLevel.ballSize * 1.4)
            .offset(offset)
            .animation(.easeInOut(duration: 3.6), value: offset)
            .blur(radius: 10)
            .opacity(0.9)
            .scaleEffect(isTapped ? 1.15 : 1.0)
    }
}


