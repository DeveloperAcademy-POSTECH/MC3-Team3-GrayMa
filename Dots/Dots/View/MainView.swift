//
//  MainView.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/17.
//

import SwiftUI

enum Tab {
    case myStrength
    case searchConnection
}

struct MainView: View {
    @State var selection: Tab = .myStrength
    @State var newContact: Bool = false
    @State var fromContact: Bool = false
    // 퀵 액션
    @EnvironmentObject var actionService: ActionService
    @Environment(\.scenePhase) var scenePhase
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.theme.disabled)
        UITabBar.appearance().backgroundColor = UIColor.white.withAlphaComponent(1.0)
    }
    
    var body: some View {
        TabView(selection: $selection) {
            MyStrengthView(tab: $selection)
                .tabItem {
                    Image("myStrengthTabIcon")
                        .renderingMode(.template)

                    Text("내 강점")
                }
                .tag(Tab.myStrength)
            
            SearchConnectionView(contactsSelectListVisible: $fromContact, navigationActive: $newContact, tab: $selection)
                .tabItem {
                    Image("networkingTabIcon")
                        .renderingMode(.template)
                    
                    Text("인맥 관리")
                }
                .tag(Tab.searchConnection)
        }
        .onChange(of: scenePhase) { newValue in
            switch newValue {
            case .active:
                performActionIfNeeded()
            default:
                break
            }
        }
    }
    
    func performActionIfNeeded() {
        guard let action = actionService.action else { return }
        
        switch action {
        case .newContact:
            selection = .searchConnection
            newContact = true
            fromContact = false
        case .fromContact:
            selection = .searchConnection
            newContact = false
            fromContact = true
        }
        
        actionService.action = nil
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
