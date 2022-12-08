//
//  AddNewCar.swift
//  ListNavDemo
//
//  Created by Deokhun KIM on 2022/10/25.
//
//사용자가 Add버튼 터치하면 ContentView에서 뷰로 전달됨

import SwiftUI
import Firebase

struct AddNewCar: View {
    //carStore연동 위해 ObservedObject 프로퍼티 생성
    @ObservedObject var carStore: CarStore
    @State var inputName : String = ""
    @Environment(\.dismiss) private var dismiss
    
    //carStore에 추가하기위해 같은 이름의 프로퍼티 생성
    @State var name: String = ""
    @State var description: String = ""
    @State var isHybrid = false
    

    
    var body: some View {            Section(header: Text("Car Details")) {
                Image(systemName: "car.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                
                DataInput(title: "Model", userInput: $name)
                DataInput(title: "Description", userInput: $description)
                
                Toggle(isOn: $isHybrid) {
                    Text("Hybrid")
                        .font(.headline)
                }.padding()
            }
            
//            Button(action: addNewCar) {
//                Text("Add car")
//            }
            Button {
                carStore.addCar(name: name,
                                description: description,
                                isHybrid: isHybrid,
                                imageName: "tesla_model_3")
            } label: {
                Text("추가하기")
            }
    }
    
//    func addNewCar() {
//        let newCar = Car(id: UUID().uuidString,
//                         name: name,
//                         description: description,
//                         isHybrid: isHybrid,
//                         imageName: "tesla_model_3")
//
//        carStore.cars.append(newCar)
//
//        dismiss()
//    }
}

//TextField뷰와 Text뷰를 나타낼 하위 뷰
struct DataInput: View {
    var title: String
    @Binding var userInput: String
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            Text(title)
                .font(.headline)
            TextField("Enter \(title)", text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct AddNewCar_Previews: PreviewProvider {
    static var previews: some View {
        //AddNewCar의 @ObservedObject var carStore는 CarStore의 cars프로퍼티(carData로 init)
        AddNewCar(carStore: CarStore())
    }
}
