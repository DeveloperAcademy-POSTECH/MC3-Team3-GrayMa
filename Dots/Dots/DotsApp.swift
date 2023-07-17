//
//  DotsApp.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/17.
//

import SwiftUI

@main
struct DotsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
