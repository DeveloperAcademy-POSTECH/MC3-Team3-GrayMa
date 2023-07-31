//
//  AppDelegate.swift
//  Dots
//
//  Created by Jae Ho Yoon on 7/31/23.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
  private let actionService = ActionService.shared

  func application(
    _ application: UIApplication,
    configurationForConnecting connectingSceneSession: UISceneSession,
    options: UIScene.ConnectionOptions
  ) -> UISceneConfiguration {

    if let shortcutItem = options.shortcutItem {
      actionService.action = Action(shortcutItem: shortcutItem)
    }

    let configuration = UISceneConfiguration(
      name: connectingSceneSession.configuration.name,
      sessionRole: connectingSceneSession.role
    )
    configuration.delegateClass = SceneDelegate.self
    return configuration
  }
}

class SceneDelegate: NSObject, UIWindowSceneDelegate {
  private let actionService = ActionService.shared

  // 7
  func windowScene(
    _ windowScene: UIWindowScene,
    performActionFor shortcutItem: UIApplicationShortcutItem,
    completionHandler: @escaping (Bool) -> Void
  ) {
    // 8
    actionService.action = Action(shortcutItem: shortcutItem)
    completionHandler(true)
  }
}
