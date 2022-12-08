//
//  AuthStore.swift
//  HelloDemo
//
//  Created by Jongwook Park on 2022/12/08.
//

import Foundation
import FirebaseAuth

class AuthStore: ObservableObject {
    @Published var userID: String? = Auth.auth().currentUser?.uid
    
    func isLogin() -> Bool {
        if let _ = userID {
            return true
        }
        
        return false
    }
}
