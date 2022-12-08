//
//  Car.swift
//  ListNavDemo
//
//  Created by 진준호 on 2022/10/25.
//

import Foundation

struct Car: Codable, Identifiable {
    var id: String
    var name: String
    
    var description: String
    var isHybrid: Bool
    
    var imageName: String
}
