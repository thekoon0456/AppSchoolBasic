//
//  AuthViewModel.swift
//  TestDemo
//
//  Created by Deokhun KIM on 2022/12/08.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    
    init() {
        
    }
    
    func registerUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            
            //회원가입 성공하면 uid출력되도록
            print(user.uid)
        }
    }
}
