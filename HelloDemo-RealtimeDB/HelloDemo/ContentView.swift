//
//  ContentView.swift
//  HelloDemo
//
//  Created by Jongwook Park on 2022/12/05.
//

import SwiftUI
//View는 언제든지 바뀔수 있음
//View는 다른 프로젝트 재사용, 다른 서버 활용할 수도 있으므로 여기에는 Firebase관련 코드 넣지 않기

struct ContentView: View {
    //Observable과 조금 다름. 추후 공부
    //store에 firebase 관련 연동을 모두 넣음
    @StateObject private var postitStore: PostitStore = PostitStore()
    @StateObject private var authStore: AuthStore = AuthStore()
    
    @State private var showingAddingSheet = false
    @State private var showingAuthSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(postitStore.postits) { postit in
                    PostitView(postit: postit)
                        .contextMenu { //contextMenu로 꾹 눌렀을때 뜨도록 만들기
                            //share추가
                            ShareLink(item: postit.textForSharing)
                            Button {
                                postitStore.deletePostit(postit: postit)
                            } label: {
                                Text("Delete")
                                Image(systemName: "trash")
                            }
                        }
                }
                
                if postitStore.postits.count < 1 {
                    Text("It's empty")
                        .padding()
                }
            }
            .listStyle(.plain) //리스트 스타일을 plane으로 하면 따로 안 떠 있음
            .listRowSeparator(.hidden) //divide선 없애기 왜 안없어져..
            .navigationBarTitle(Text("PostIt"))
            .onAppear {
                postitStore.startFetching()
            }
            .onDisappear {
                postitStore.startFetching()
            }
            .toolbar {
                if authStore.isLogin() {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("LogOut") {
//                            showingAuthSheet.toggle()
                        }
                    }
                } else {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("LogIn") {
                            showingAuthSheet.toggle()
                        }
                    }
                }
                
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        showingAddingSheet.toggle()
                    }
                }
                
            }
            .sheet(isPresented: $showingAddingSheet) {
                //postitStore: postitStore 여기 안에 있는 postitStore보내주기, PostitStore()로 하면 새거를 넘겨줌
                PostitAddingView(postitStore: postitStore, showingSheet: $showingAddingSheet)
            }
            .sheet(isPresented: $showingAuthSheet) {
                AuthView(showingSheet: $showingAddingSheet)
            }
        }
    }
}

struct PostitView: View {
    var postit: Postit
    
    var body: some View {
        //글은 왼쪽으로 정렬
        LazyVStack(alignment: .leading) {
            Text(postit.memo)
                .padding()
            
            //유저는 오른쪽으로 밀기
            HStack {

                Text(postit.user)
                    .font(.footnote)
                    .padding()
                Spacer()
                Text("\(postit.createdDate)")
            }
        }
        .background(postit.color) //연산프로퍼티 활용
        .shadow(radius: 6) //살짝 떠있는거처럼 shwdow활용
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
