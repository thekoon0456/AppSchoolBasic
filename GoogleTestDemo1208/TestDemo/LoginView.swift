//
//  LoginView.swift
//  TestDemo
//
//  Created by 진준호 on 2022/12/08.
//

//import SwiftUI
//
//struct LoginView: View {
//    @State private var id: String = ""
//    @State private var pw: String = ""
//
//    var body: some View {
//        NavigationStack {
//            VStack {
//                TextField("아이디를 입력해주세요", text: $id)
//                    .font(.title2)
//
//                SecureField("비밀번호를 입력해주세요", text: $pw)
//                    .font(.title2)
//
//                Button {
//
//                } label: {
//                    Text("로그인")
//                }
//                .padding(.top, 10)
//
//                NavigationLink(destination: AuthView()) {
//                    Text("회원가입하러 가기")
//                }
//                .padding(.top, 10)
//            }
//            .padding(.horizontal, 20)
//        }
//    }
//}

import SwiftUI

struct LoginView: View {

  // 1
  @EnvironmentObject var viewModel: AuthenticationViewModel

  var body: some View {
    VStack {
      Spacer()

      // 2
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

      // 3
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
