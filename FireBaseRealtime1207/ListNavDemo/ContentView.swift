//
//  ContentView.swift
//  ListNavDemo
//
//  Created by 진준호 on 2022/10/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var carStore: CarStore = CarStore()
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(carStore.cars) { car in
                    ListCell(car: car)
                }
                .onDelete(perform: deleteItems)
                .onMove(perform: moveItems)
            }
            .navigationBarTitle(Text("EV Cars"))
            .onAppear {
                carStore.listentoRealtimeDatabase()
            }
            .onDisappear {
                carStore.stopListening()
            }
            .navigationBarItems(leading: NavigationLink(destination: AddNewCar(carStore: self.carStore)) {
                Text("Add")
                    .foregroundColor(.blue)
            }, trailing: EditButton())
        }
    }
    
    //offset: IndexSet = 인덱스 값이 뜸.
    func deleteItems(at offset: IndexSet) {
        carStore.deleteCar(id:
                            //carStore에 배열cars의 인덱스 번호 입력하고, last로 뽑아줌. 그 배열의 아이디값을 불러오면 키값이 불러와짐. 키값을 deleteCar 매개변수에 던져줘서 작동하도록
                           //id는 Database에 있는 큰 아이디값.
                           carStore.cars[offset.last ?? 0].id)
    }
    
    func moveItems(from source: IndexSet, to destination: Int) {
        carStore.cars.move(fromOffsets: source, toOffset: destination)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ListCell: View {
    
    var car: Car
    
    var body: some View {
        
        NavigationLink(destination: CarDetail(selectedCar: car)) {
            HStack {
                Image(car.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 60)
                Text(car.name)
            }
        }
    }
}
