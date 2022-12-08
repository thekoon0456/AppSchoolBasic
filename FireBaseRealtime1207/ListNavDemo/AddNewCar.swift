//
//  AddNewCar.swift
//  ListNavDemo
//
//  Created by 진준호 on 2022/10/25.
//

import SwiftUI

struct AddNewCar: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var carStore: CarStore
    
    @State var isHybrid = false
    @State var name: String = ""
    @State var description: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Car Details")) {
                Image(systemName: "car.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                
                DataInput(title: "Model", userInput: $name)
                DataInput(title: "Description", userInput: $description)
                
                Toggle(isOn: $isHybrid) {
                    Text("Hybrid").font(.headline)
                }
                .padding()
            }
            
            Button(action: addNewCar) {
                Text("Add Car")
            }
        }
    }
    
    func addNewCar() {
        carStore.addCar(name: name, imageName: "tesla_model_3", isHybrid: isHybrid, description: description)
        
        dismiss()
    }
}

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
        .padding()
    }
}

struct AddNewCar_Previews: PreviewProvider {
    static var previews: some View {
        AddNewCar(carStore: CarStore())
    }
}
