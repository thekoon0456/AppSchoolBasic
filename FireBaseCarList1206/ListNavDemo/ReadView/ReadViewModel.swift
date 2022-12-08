//
//  ReadViewModel.swift
//  ListNavDemo
//
//  Created by Deokhun KIM on 2022/12/07.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class ReadViewModel: ObservableObject {
    var ref = Database.database().reference()
    
    @Published
    var value: String? = nil
    
    func readValue() {
        ref.child("KeyA").observeSingleEvent(of: .value) { snapshot in
            self.value = snapshot.value as? String
        }
    }
}
