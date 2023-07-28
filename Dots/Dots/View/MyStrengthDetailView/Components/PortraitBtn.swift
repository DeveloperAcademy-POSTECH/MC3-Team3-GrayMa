//
//  PortraitBtn.swift
//  Dots
//
//  Created by Jae Ho Yoon on 7/19/23.
//

import SwiftUI

struct PortraitBtn: View {
    var entity: NetworkingPersonEntity
    
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.87, green: 0.29, blue: 0.28), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.96, green: 0.93, blue: 0.86), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.5, y: -0.18),
                        endPoint: UnitPoint(x: 0.5, y: 1.46)
                    ))
                .frame(width: 76)
            Button(action: {
                // 인맥 페이지로 들어가기
                
            }, label: {
                ZStack {
                    Circle()
                        .frame(width: 64)
                        .foregroundColor(Color.theme.secondary)
                    Text(entity.name ?? "")
                        .modifier(boldTitle2(colorName: .theme.text))
                        .frame(width: 64)
                        .scaledToFit()
                }
            })
        }
    }
}
