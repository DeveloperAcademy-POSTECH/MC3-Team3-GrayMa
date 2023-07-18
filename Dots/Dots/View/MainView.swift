//
//  MainView.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/17.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            MyStrengthView()
                .tabItem {
                    Text("\(Image(systemName: "star.fill"))")
                    Text("내 강점")
                }
            
            VStack{
                Text("asdf")
            }
            .tabItem {
                Text("\(Image(systemName: "star.fill"))")
                Text("인맥 관리")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
