//
//  PortraitBtn.swift
//  Dots
//
//  Created by Jae Ho Yoon on 7/19/23.
//

import SwiftUI

struct PortraitBtn: View {
    var name: String
    var hasPortrait: Bool
    var portraitName: String
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 80)
                .foregroundColor(.white)
            Button(action: {
                
                
            }, label: {
                ZStack {
                    if hasPortrait {
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
                            Text(name)
                                .frame(width: 64)
                                .scaledToFit()
                        }
                    }
                }
            })
        }
    }
}

