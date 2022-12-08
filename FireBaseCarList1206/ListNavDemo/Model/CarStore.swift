//
//  CarStore.swift
//  ListNavDemo
//
//  Created by Deokhun KIM on 2022/10/25.
//

//carData에서 땡겨온 JSON 데이터 배열을 CarStore의 cars 배열에 저장한다.
//Car는 계란, CarStore는 계란판. 여기에 Car들이 담김
import SwiftUI
import Combine
import FirebaseDatabase

//list뷰에 항상 최신 데이터가 연동되어야 하므로 ObservableObject생성
//데이터 저장소 구조체 추가
//다른 뷰에서 @ObservedObject var carStore: CarStore = CarStore(cars: carData)로 carData 담아서 사용함
class CarStore: ObservableObject {
    @Published var cars: [Car] = []
    
    private lazy var databasePath: DatabaseReference? = {
        let ref = Database.database().reference().child("cars")
        return ref
    }()
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func listentoRealtimeDatabase() {
        guard let databasePath = databasePath else {
            return
        }
        databasePath.observe(.childAdded) { [weak self] snapshot in
            guard
                let self = self,
                var json = snapshot.value as? [String: Any]
            else {
                return
            }
            json["id"] = snapshot.key
            do {
                let carData = try JSONSerialization.data(withJSONObject: json)
                let car = try self.decoder.decode(Car.self, from: carData)
                self.cars.append(car)
            } catch {
                print("an error occurred", error)
            }
        }
    }
    
    func stopListening() {
        databasePath?.removeAllObservers()
    }
    
//    func refreshDatabase() {
//        self.cars = []
//        self.listentoRealtimeDatabase()
//    }
    
    func addCar(name: String, description: String, isHybrid: Bool, imageName: String) {
        let uuid = UUID().uuidString
        Database.database().reference().child("cars").child(uuid).setValue(["id" : uuid, "name": name, "description": description, "isHybrid": isHybrid, "imageName": "tesla_model_s"])
    }
    
    func updateCar(id : String) {
        let changeName = "testUpdate"
        Database.database().reference().child("cars").child(id).child("name").setValue(changeName)
//        refreshDatabase()
    }
    
    func removeCar(id : String) {
        Database.database().reference().child("cars").child(id).removeValue()
//        refreshDatabase()
    }
    
    
}


