//
//  LoginView.swift
//  TestDemo
//

import SwiftUI

struct LoginView: View {

  // 1. EnvironmentObject: AuthenticationViewModel 객체를 수신하기 위한 환경 객체. 이렇게 하면 앱의 SwiftUI 수명 주기에 선언된 클래스의 한 인스턴스를 사용할 수 있음.
  @EnvironmentObject var viewModel: AuthenticationViewModel

  var body: some View {
    VStack {
      Spacer()

      // 2. 로그인 뷰 구성
      Image("header_image")
        .resizable()
        .aspectRatio(contentMode: .fit)

      Text("Welcome to Ellifit!")
        .fontWeight(.black)
        .foregroundColor(Color(.systemIndigo))
        .font(.largeTitle)
        .multilineTextAlignment(.center)

      Text("Empower your elliptical workouts by tracking every move.")
        .fontWeight(.light)
        .multilineTextAlignment(.center)
        .padding()

      Spacer()

      // 3. 로그린 버튼뷰 호출
      GoogleSignInButton()
        .padding()
        .onTapGesture {
          viewModel.signIn()
        }
    }
  }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
