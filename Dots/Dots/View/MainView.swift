//
//  MainView.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/17.
//

import SwiftUI

struct MainView: View {
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.theme.disabled)
        UITabBar.appearance().backgroundColor = UIColor.white.withAlphaComponent(0.7)
    }
    
    var body: some View {
        TabView{
            MyStrengthView()
                .tabItem {
                    Image("myStrengthTabIcon")
                        .renderingMode(.template)

                    Text("내 강점")
                }
            
            SearchConnectionView(companyName:.constant("삼성"), jobName:.constant("개발자") , strengthName: .constant("개발"))
                .tabItem {
                    Image("networkingTabIcon")
                        .renderingMode(.template)
                    
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
