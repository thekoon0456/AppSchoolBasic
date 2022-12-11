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
    //전체 생명주기동안 살아있을 변수 만듬, 뷰가 동일한 뷰모델에 엑세스하도록 environment로 contentview에 전달
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

//호출하면 configure()기본 Firebase 앱이 구성됨. 내부에서 EllifitApp,인증을 설정하기 위한 초기화 프로그램을 만듬.
extension TestDemoApp {
  private func setupAuthentication() {
    FirebaseApp.configure()
  }
}
