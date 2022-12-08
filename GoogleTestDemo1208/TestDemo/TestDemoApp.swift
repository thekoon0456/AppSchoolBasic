//
//  TestDemoApp.swift
//  TestDemo
//
//  Created by 진준호 on 2022/12/08.
//

import SwiftUI
import FirebaseCore
import Firebase
import GoogleSignIn


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct TestDemoApp: App {
    
    @StateObject var viewModel = AuthenticationViewModel()
    
  init() {
    setupAuthentication()
  }

  var body: some Scene {
    WindowGroup {
        ContentView().environmentObject(viewModel)
    }
  }
}

extension TestDemoApp {
  private func setupAuthentication() {
    FirebaseApp.configure()
  }
}
