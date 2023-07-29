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
        NavigationLink {
            ConnectionDetailView(person: entity)
        } label: {
            VStack {
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
                    Circle()
                        .frame(width: 64)
                        .foregroundColor(Color.theme.secondary)
                    
                    // MARK: 이미지 index가 없으면 일단 1번 이미지로 보이도록 임시로 처리 추후 수정 필요
                    Image("user_default_profile \(entity.profileImageIndex == 0 ? 1 : entity.profileImageIndex)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 64)
                }
                Text(entity.name ?? "")
                    .modifier(regularCaption1(colorName: Color.theme.text))
            }
        }
    }
}

