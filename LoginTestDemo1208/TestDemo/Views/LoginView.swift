//
//  LoginView.swift
//  TestDemo
//
//  Created by 진준호 on 2022/12/08.
//

import SwiftUI

struct LoginView: View {
    @State private var id: String = ""
    @State private var pw: String = ""
    //다중 뷰에서 데이터를 다룰때 편하니까 EnvironmentObject로 사용
    
    @EnvironmentObject var viewModel: LoginViewModel
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(viewModel.currentUser?.uid ?? "비로그인")
                    .padding()
                
                TextField("아이디를 입력해주세요", text: $id)
                    .font(.title2)
                
                SecureField("비밀번호를 입력해주세요", text: $pw)
                    .font(.title2)
                
                Button {
                    viewModel.login(email: id, password: pw)
                } label: {
                    Text("로그인")
                }
                .padding(.top, 10)
                
                Button {
                    viewModel.logout()
                } label: {
                    Text("로그아웃")
                }
                .padding(.top, 10)
                
                NavigationLink(destination: AuthView()) {
                    Text("회원가입하러 가기")
                }
                .padding(.top, 10)
            }
            .padding(.horizontal, 20)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        //EnvironmentObject 사용시
        LoginView().environmentObject(LoginViewModel())
    }
}
