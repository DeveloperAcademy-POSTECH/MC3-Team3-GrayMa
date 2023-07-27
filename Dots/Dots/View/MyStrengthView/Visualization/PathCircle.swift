//
//  PathCircle.swift
//  Dots
//
//  Created by 정승균 on 2023/07/27.
//

import SwiftUI

struct PathCircle: View {
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State var position: CGPoint = CGPoint(x: 0, y: 0)
    @State var strengthBalls: [StrengthBall] = [
        .init(center: CGPoint(x: 100, y: 100), radius: 50),
        .init(center: CGPoint(x: 200, y: 200), radius: 50)
    ]
    
    @State var offset: CGSize = .init(width: 0, height: 0)
    
    var body: some View {
        VStack {
            MyCircle(name: "Name", offset: offset)
        }
        .onReceive(timer) { _ in
            withAnimation(.easeIn(duration: 3)) {
                offset = CGSize(width: .random(in: -100...100), height: .random(in: -200...200))
            }
        }
    }
}

struct PathCircle_Previews: PreviewProvider {
    static var previews: some View {
        PathCircle()
    }
}

struct StrengthBall {
    var center: CGPoint
    var radius: CGFloat
}

struct MyCircle: View {
    let name: String
    let size: CGFloat = 100
    @State var offset: CGSize
    
    var body: some View {
        ZStack {
            MyCircleEntity()
            
            Text(name)
                .foregroundColor(.theme.bgMain)
                .bold()
        }
        .frame(width: size, height: size)
        .offset(offset)
    }
}

struct MyCircleEntity: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.addEllipse(in: rect)
        }
    }
}
