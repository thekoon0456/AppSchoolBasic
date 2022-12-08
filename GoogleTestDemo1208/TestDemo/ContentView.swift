//
//  ContentView.swift
//  TestDemo
//
//  Created by 진준호 on 2022/12/08.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var viewModel: AuthenticationViewModel
  
  var body: some View {
    switch viewModel.state {
      case .signedIn: HomeView()
      case .signedOut: LoginView()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
