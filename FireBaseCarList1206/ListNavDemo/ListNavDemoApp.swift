//
//  ListNavDemoApp.swift
//  ListNavDemo
//
//  Created by Deokhun KIM on 2022/10/25.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}


@main
struct ListNavDemoApp: App {
    //Firebase 설정을 위한 delegate 등록
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
//            ReadView()
        }
    }
}
