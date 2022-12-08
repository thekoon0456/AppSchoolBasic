//
//  AuthView.swift
//  TestDemo
//
//  Created by 진준호 on 2022/12/08.
//

import SwiftUI

struct AuthView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var id: String = ""
    @State private var pw: String = ""
    
    @ObservedObject var viewModel = AuthViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("아이디를 입력해주세요", text: $id)
                    .font(.title2)
                
                SecureField("비밀번호를 입력해주세요", text: $pw)
                    .font(.title2)
                
                Button {
                    viewModel.registerUser(email: id, password: pw)
                    dismiss
                } label: {
                    Text("회원가입")
                }
                .padding(.top, 10)
            }
            .padding(.horizontal, 20)
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
