//
//  Action.swift
//  Dots
//
//  Created by Jae Ho Yoon on 7/31/23.
//  퀵 액션 정의

import UIKit

enum ActionType: String {
    case newContact = "newContact"
    case fromContact = "fromContact"
}

enum Action: Equatable {
    case newContact
    case fromContact
    
    init?(shortcutItem: UIApplicationShortcutItem) {
        guard let type = ActionType(rawValue: shortcutItem.type) else {
            return nil
        }
        
        switch type {
        case .newContact:
            self = .newContact
        case .fromContact:
            self = .fromContact
        }
    }
}

class ActionService: ObservableObject {
    static let shared = ActionService()
    
    @Published var action: Action?
}
