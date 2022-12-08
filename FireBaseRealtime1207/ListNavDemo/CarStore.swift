//
//  CarStore.swift
//  ListNavDemo
//
//  Created by 진준호 on 2022/10/25.
//

import Foundation
import FirebaseDatabase

class CarStore: ObservableObject {
    
    @Published var cars: [Car] = []
    
    var ref: DatabaseReference = Database.database().reference()
    
    private lazy var databasePath: DatabaseReference? = {
        //cars까지 database가 타고 들어감
        let ref = Database.database().reference().child("cars")
        return ref
    }()

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    func listentoRealtimeDatabase() {
        guard let databasePath = databasePath else {
            return
        }
        databasePath
        //child를 추가함
            .observe(.childAdded) { [weak self] snapshot in
                guard
                    let self = self,
                    var json = snapshot.value as? [String: Any]
                else {
                    return
                }
                
                //DataBase에 있는 키값을 가져와서 JSON에 id 안으로 넣음
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

    //위의 함수가 onAppear될때
    func stopListening() {
        databasePath?.removeAllObservers()
        self.cars = []
    }
    
    //데이터를 새로 작성하는 함수, 매개변수로 받아와서 넣음
    func addCar(name: String, imageName: String, isHybrid: Bool, description: String) {
        //키값 새로 세팅, setValue 메소드로 데이터 추가
        databasePath?.childByAutoId().setValue(["description": description, "id": UUID().uuidString, "imageName": imageName, "name": name, "isHybrid":isHybrid ])
    }
    
    //데이터를 삭제하는 함수
    func deleteCar(id: String) {
        //removeValue()하면 다 날림, 키값을 가져와서 그 키값을 날리기
        //databasePath해서 cars받아오고, 키값 받아와서 키값 가지고 있는 밸류들 없애라
        databasePath?.child(id).removeValue()
    }
}
