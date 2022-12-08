//
//  ReadView.swift
//  ListNavDemo
//
//  Created by Deokhun KIM on 2022/12/07.
//

import SwiftUI

struct ReadView: View {
    @StateObject
    var viewModel = ReadViewModel()
    var body: some View {
        
        VStack {
            if viewModel.value != nil {
                Text(viewModel.value!)
            } else {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }

            Button {
                viewModel.readValue()
            } label: {
                Text("Read")
            }
        }.padding()
    }
}

struct ReadView_Previews: PreviewProvider {
    static var previews: some View {
        ReadView()
    }
}
