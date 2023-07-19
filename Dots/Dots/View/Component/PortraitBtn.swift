//
//  PortraitBtn.swift
//  Dots
//
//  Created by Jae Ho Yoon on 7/19/23.
//

import SwiftUI

struct DummyPortrait: Hashable {
    var name: String
    var portraitName: String?
}

var dummyPortraitData: [DummyPortrait] = [
    DummyPortrait(name: "Marcus", portraitName: "testPortrait"),
    DummyPortrait(name: "Gyunni"),
    DummyPortrait(name: "Rash", portraitName: "testPortrait")
]

struct PortraitBtn: View {
    var entity: DummyPortrait
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 80)
                .foregroundColor(.white)
            Button(action: {
                
                
            }, label: {
                ZStack {
                    if let portraitName = entity.portraitName {
                        Image(portraitName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 64, height: 64)
                            .clipShape(Circle())
                    } else {
                        ZStack {
                            Circle()
                                .frame(width: 64)
                                .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.97))
                            Text(entity.name)
                                .frame(width: 64)
                                .scaledToFit()
                        }
                    }
                }
            })
        }
    }
}
