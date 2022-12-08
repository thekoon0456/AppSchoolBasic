//
//  CarDetail.swift
//  ListNavDemo
//
//  Created by Deokhun KIM on 2022/10/25.
//
//상세뷰 구현

import SwiftUI

struct CarDetail: View {
    
    let selectedCar: Car
    
    var body: some View {
        Form {
            Section(header: Text("Car Details")) {
                Image(selectedCar.imageName ?? "")
                    .resizable()
                    .cornerRadius(12.0)
                    .aspectRatio(contentMode: .fit)
                    .padding()
                
                Text(selectedCar.name ?? "")
                    .font(.headline)
                
                Text(selectedCar.description ?? "")
                    .font(.body)
                
                HStack {
                    Text("Hybrid")
                        .font(.headline)
                    Spacer()
                    Image(systemName: selectedCar.isHybrid ?? false ? "checkmark.circle" : "xmark.circle")
                }
            }
        }
    }
}

struct CarDetail_Previews: PreviewProvider {
    static var previews: some View {
        CarDetail(selectedCar: carData[0])
    }
}
