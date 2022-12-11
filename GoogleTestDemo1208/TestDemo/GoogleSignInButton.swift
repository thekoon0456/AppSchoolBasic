//
//  GoogleSignInButton.swift
//  TestDemo
//
//  Created by Deokhun KIM on 2022/12/08.
//

import SwiftUI
import GoogleSignIn


//로그인 버튼 뷰,
//SwiftUI로 작업할 때 Google 로그인 SDK에서 제공하는 "Google로 로그인" 버튼을 사용할 수 있지만 UIViewRepresentable 프로토콜 따라야 함. 버튼을 다크모드, 라이트모드로 대응 가능하도록
struct GoogleSignInButton: UIViewRepresentable {
  //시스템 색 구성 따라 색 바꿈
  @Environment(\.colorScheme) var colorScheme
  
  private var button = GIDSignInButton()

  func makeUIView(context: Context) -> GIDSignInButton {
    button.colorScheme = colorScheme == .dark ? .dark : .light
    return button
  }

  func updateUIView(_ uiView: UIViewType, context: Context) {
    button.colorScheme = colorScheme == .dark ? .dark : .light
  }
}
