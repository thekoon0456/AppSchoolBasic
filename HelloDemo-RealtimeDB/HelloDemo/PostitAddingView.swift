//
//  PostitAddingView.swift
//  HelloDemo
//
//  Created by Jongwook Park on 2022/12/08.
//

import SwiftUI

struct PostitAddingView: View {
    @StateObject var postitStore: PostitStore
    
    //showingSheet 바인딩으로 가져옴
    @Binding var showingSheet: Bool
    
    @State private var user: String = "steve"
    @State private var memo: String = ""
    @State private var colorIndex: Int = 0
    
    let colors: [Color] = [.cyan, .purple, .blue, .yellow, .brown]
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Form {
                    Section(header: Text("Select a color")) {
                        HStack {
                            //enumerated로 튜플로 인덱스, 값 같이 가져옴
                            ForEach(Array(colors.enumerated()), id: \.offset) { (index, color) in
                                Button {
                                    print("selected: \(index)")
                                    colorIndex = index
                                } label: {
                                    ZStack {
                                        Rectangle()
                                            .frame(height: 60)
                                            .foregroundColor(color)
                                            .shadow(radius: 6)
                                        //선택됐을때 체크마크 뜨도록 if문으로 ZStack으로 올려줌
                                        if index == colorIndex {
                                            Image(systemName: "checkmark")
                                                .font(.title)
                                                .foregroundColor(.white)
                                                .padding()
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    Divider()
                    Section(header: Text("Write a memo")) {
                        //axis: .vertical 스유4.0 기능, 텍스트필드가 옆으로 안넘어가고 화면에 차게 나옴
                        TextField("Memo", text: $memo, axis: .vertical)
                    }
                    .padding()
                    Spacer()
                }
            }
            .navigationTitle("Add new Post")
            .formStyle(.columns) //사각형 따로 눌림 / .grouped로 하면 다 눌러짐
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        showingSheet.toggle()
                    }
                }
                //submit 버튼이 메모 길이가 0보다 클때만 보이도록
                if memo.trimmingCharacters(in: .whitespaces).count > 0 {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Submit") {
                            let time = Date().timeIntervalSince1970
                            memo = memo.trimmingCharacters(in: .whitespaces)
                            let postit = Postit(id: UUID().uuidString, user: "steve", memo: memo, colorIndex: colorIndex, createdAt: time)
                            postitStore.addPostit(postit: postit)
                            
                            showingSheet.toggle()
                        }
                    }
                }
            }
        }
    }
}

struct PostitAddingView_Previews: PreviewProvider {
    //private말고 static으로 사용하면 프리뷰에서 사용가능
    @State static var showingSheet = false
    
    static var previews: some View {
        PostitAddingView(postitStore: PostitStore(), showingSheet: $showingSheet)
    }
}
