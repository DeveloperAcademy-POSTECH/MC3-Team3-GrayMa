//
//  DotsApp.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/17.
//

import SwiftUI

@main
struct DotsApp: App {
//    let persistenceController = PersistenceController.shared
    @StateObject var dotsModel: DotsModel = DotsModel()
    let filterModel = FilterModel(companyName: "", jobName: "", strengthName: "")
    private let actionService = ActionService.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = .systemBlue
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(dotsModel)
                .environmentObject(filterModel)
                .environmentObject(actionService)
        }
    }
}
