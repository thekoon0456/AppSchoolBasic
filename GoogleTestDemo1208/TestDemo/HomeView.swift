//
//  HomeView.swift
//  TestDemo
//
//  Created by Deokhun KIM on 2022/12/08.
//

import SwiftUI
import GoogleSignIn

struct HomeView: View {
  // 1. EnvironmentObject선언
  @EnvironmentObject var viewModel: AuthenticationViewModel
  
  // 2. GIDSignIn의 공유 인스턴스 사용하기위한 상수, 현재 사용자에게 엑세스
  private let user = GIDSignIn.sharedInstance.currentUser
  
  var body: some View {
    NavigationView {
      VStack {
        HStack {
          // 3. user 이용해 사용자의 Google 계정의 프로필 사진, 사용자 이름 및 이메일 주소에 액세스함
          NetworkImage(url: user?.profile?.imageURL(withDimension: 200))
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100, alignment: .center)
            .cornerRadius(8)
          
          VStack(alignment: .leading) {
            Text(user?.profile?.name ?? "")
              .font(.headline)
            
            Text(user?.profile?.email ?? "")
              .font(.subheadline)
          }
          
          Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .padding()
        
        Spacer()
        
        // 4. 뷰모델에서 signOut() 메서드를 호출하는 로그아웃 버튼.
        Button(action: viewModel.signOut) {
          Text("Sign out")
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.systemIndigo))
            .cornerRadius(12)
            .padding()
        }
      }
      .navigationTitle("Ellifit")
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

/// A generic view that shows images from the network.
struct NetworkImage: View {
  let url: URL?

  var body: some View {
    if let url = url,
       let data = try? Data(contentsOf: url),
       let uiImage = UIImage(data: data) {
      Image(uiImage: uiImage)
        .resizable()
        .aspectRatio(contentMode: .fit)
    } else {
      Image(systemName: "person.circle.fill")
        .resizable()
        .aspectRatio(contentMode: .fit)
    }
  }
}
