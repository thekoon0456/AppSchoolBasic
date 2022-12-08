//
//  ListViewCell.swift
//  ListNavDemo
//
//  Created by Deokhun KIM on 2022/11/28.
//

import SwiftUI

//하위뷰 만들어서 뺌
struct ListCell: View {
    
    var car: Car
    @StateObject var carStore : CarStore
    
    var body: some View { //네비게이션 링크로 CarDetail이동
        NavigationLink(destination: CarDetail(selectedCar: car)) {
            HStack {
                Image(car.imageName ?? "tesla_model_3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 60)
                Text(car.name ?? "")
            }
            .onTapGesture(count: 2) {
                carStore.updateCar(id: car.id ?? "")
            }
        }
    }
}

////프리뷰로 배열 다 읽기 어려움. 배열 첫번째 사진 프리뷰로 보기
struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        ListCell(car: carData.first!, carStore: CarStore())
    }
}
