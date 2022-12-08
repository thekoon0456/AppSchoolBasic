//
//  CarData.swift
//  ListNavDemo
//
//  Created by Deokhun KIM on 2022/10/25.
//

//carData.json 파일 읽어와서 Car객체로 변환한 다음에 배열에 넣음

import UIKit
import SwiftUI

//loadJson함수로 JSON파싱해서 carData에 배열로 담음
var carData: [Car] = loadJson("carData.json")

func loadJson<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename,
                        withExtension: nil)
    else {
        fatalError("\(filename) not found.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Could not load \(filename): (error)")
    }
    
    do {
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        fatalError("Unable to parse \(filename): (error)")
    }
}
