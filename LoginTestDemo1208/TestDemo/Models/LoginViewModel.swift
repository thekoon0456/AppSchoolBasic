//
//  LoginViewModel.swift
//  TestDemo
//
//  Created by Deokhun KIM on 2022/12/08.
//

import SwiftUI
import Firebase
import FirebaseAuth

class LoginViewModel: ObservableObject {
    
    //현재 유저 상태, 이걸안쓰면 현재 유저상태보기 어렵고, 앱을 껏을때 로그인이 유지가 안됨
    @Published var currentUser: Firebase.User?
    
    init() {
        currentUser = Auth.auth().currentUser
    }
    
    //로그인 해주는 함수
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            //로그인 하게되면 currentUser에 넣어줌
            self.currentUser = result?.user
        }
    }
    
    //로그아웃 해주는 함수
    func logout() {
        currentUser = nil
        try? Auth.auth().signOut()
    }
    
    func registerUser(email: String, password: String) {
        // 생략
    }
}
