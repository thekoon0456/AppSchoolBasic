//
//  Postit.swift
//  HelloDemo
//
//  Created by Jongwook Park on 2022/12/08.
//

import Foundation
import SwiftUI

struct Postit: Codable, Identifiable {
    var id: String
    var user: String
    var memo: String
    //컬러 그대로 제이슨에서 읽기 힘듬. 인덱스값 보내주고 연산프로퍼티 활용
    var colorIndex: Int
    //언제 만들어졌는지 날짜확인, firebase에서
    var createdAt: Double
    
    //연산프로퍼티, switch활용해서 colorIndex사용해 컬러 가져옴
    var color: Color {
        get {
            switch colorIndex {
            case 0:
                return .cyan
            case 1:
                return .purple
            case 2:
                return .blue
            case 3:
                return .yellow
            case 4:
                return .brown
            default:
                return .white
            }
        }
    }
    
    //연산프로퍼티 활용해 시간 넣기
    var createdDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        //한국 타임존(위도경도 기준)
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        //날짜, 시간 포맷 설정
        dateFormatter.dateFormat = "yyyy-MM-dd"
//        "yyyy-MM-dd HH:mm:ss"
        //어제, 오늘, 내일 등 설정 해보기
        
        let dateCreatedAt = Date(timeIntervalSince1970: createdAt)
        
        return dateFormatter.string(from: dateCreatedAt)
    }
    
    //연산프로퍼티 활용해 공유항목 늘림
    var textForSharing: String {
        return "\(memo)\n\(user)\n\(createdDate)"
    }
}

