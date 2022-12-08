//
//  Car.swift
//  ListNavDemo
//
//  Created by Deokhun KIM on 2022/10/25.
//

//자동차 모델 나타내는 구조체

import SwiftUI

struct Car: Codable, Identifiable { //Codable가 JSON 파싱해줌, 인코딩, 디코딩 쉽게 가능. Identifiable프로토콜 따르므로 List뷰에서 식별할 수 있다
    //JSON 각 필드에 대한 프로퍼티
    var id: String? //이미 id값이 각각 다르게 정해져 있으므로 UUID()따로 사용 안함
    var name: String?
    
    var description: String?
    var isHybrid: Bool?
    
    var imageName: String?
}
