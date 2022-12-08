//
//  ContentView.swift
//  ListNavDemo
//
//  Created by Deokhun KIM on 2022/10/25.
//

import SwiftUI

struct ContentView: View {
    //carStore의 cars에 carData를 init해서 넣음.
//    @ObservedObject var carStore: CarStore =  CarStore(cars: carData) //구독 객체 바인딩 추가
    @StateObject private var carStore : CarStore = CarStore()
    
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView { //ListCell의 네비게이션링크 동작하려면 NavigationView 안에 넣어야함.
            List { //자동차 정보 표시하는 List뷰
                ForEach(carStore.cars) { car in
                    ListCell(car: car, carStore: carStore) //ListCell의 car에 foreach car 하나씩 넣어서 출력
                }
                //Edit버튼 사용시 메서드 구현
                .onDelete(perform: deleteItems)
                .onMove(perform: moveItems)
            }
            .navigationTitle("EV Cars")
            .navigationBarItems(leading: NavigationLink("Add", destination: {
                AddNewCar(carStore: carStore.self) //네비게이션 링크로 AddNewCar뷰로 이동
            }) , trailing: EditButton())//edit버튼 알아서 생성
            .onAppear {
                carStore.listentoRealtimeDatabase()
            }
            .onDisappear {
                carStore.stopListening()
                carStore.cars = []
            }
            
            //교재
//            .navigationBarTitle(Text("EV Cars"))
//            .navigationBarItems(leading: NavigationLink(destination: AddNewCar(carStore: self.carStore)) {
//                Text("Add")
//                    .foregroundColor(.blue)
//            }, trailing: EditButton())

        }
    }
    
    //지웠을때 실행될 함수
    func deleteItems(at offset: IndexSet) {
        carStore.cars.remove(atOffsets: offset)
    }
    
    //이동시 실행될 함수
    func moveItems(from source: IndexSet, to destination: Int) {
        carStore.cars.move(fromOffsets: source, toOffset: destination)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




