//
//  PostitStore.swift
//  HelloDemo
//
//  Created by Jongwook Park on 2022/12/08.
//

//뷰모델 - 서버쪽은 뷰가 없으니까 뷰모델이라고 하기 보다는 store라고 쓰는듯?


import Foundation
import FirebaseDatabase

class PostitStore: ObservableObject {
    //내용이 쌓일 배열
    @Published var postits: [Postit] = [] //Published 이 내용이 바뀌면 화면이 다시 그리도록

    //postits 초기화
    init() {
        postits = [
            Postit(id: UUID().uuidString, user: "ned", memo: "Good morning", colorIndex: 0, createdAt: Date().timeIntervalSince1970), //1970년부터 지금까지 흐른 시간, Double타입, 추후에 환원해서 넣어야 함
            Postit(id: UUID().uuidString, user: "ned", memo: "Good evening", colorIndex: 1, createdAt: Date().timeIntervalSince1970),
            Postit(id: UUID().uuidString, user: "ned", memo: "Good afternoon", colorIndex: 2, createdAt: Date().timeIntervalSince1970),
            Postit(id: UUID().uuidString, user: "ned", memo: "Good morning", colorIndex: 3, createdAt: Date().timeIntervalSince1970)
            
        ]
    }
    
    //국룰, databaseReference
    private lazy var databaseReference: DatabaseReference? = {
        //ref
            let reference = Database.database().reference().child("postits")
            return reference
        }()
    
    //JSON처리
    private let encoder = JSONEncoder() //JSON을 struct로 바꿈
    private let decoder = JSONDecoder() //struct를 JSON으로 바꿈
    
    //Firebase연동할 함수
    
    //
    func startFetching() {
        //databaseReference 찾아서 없으면 끝냄
        guard let databaseReference else {
            return
        }
        //databaseReference 있으면 진행
        databaseReference
        //시작하면 observe가 계속 돌면서 해당 항목을 확인하고 하나씩 값을 넣음
        //.childAdded 서버와 비교해서 이런게 더 있으면 하나씩 받아와서 보여줌
            .observe(.childAdded) { [weak self] snapshot in
                guard
                    let self = self,
                    var json = snapshot.value as? [String: Any]
                else {
                    return
                }
                //키
                json["id"] = snapshot.key
                
                do {//JSON디코더
                    let postitData = try JSONSerialization.data(withJSONObject: json)
                    let postit = try self.decoder.decode(Postit.self, from: postitData)
                    print(postit)
                    
                    //새로운게 오면 맨 앞에 넣기
                    self.postits.insert(postit, at: 0)
                } catch {
                    print("an error occurred", error)
                }
        }
        
        databaseReference
        //.childChange 서버와 비교해서 내용이 변경되었을때
            .observe(.childChanged) { [weak self] snapshot in
                guard
                    let self = self,
                    var json = snapshot.value as? [String: Any]
                else {
                    return
                }
                
                json["id"] = snapshot.key
                
                do {
                    let postitData = try JSONSerialization.data(withJSONObject: json)
                    let postit = try self.decoder.decode(Postit.self, from: postitData)
                    print(postit)
                    
                    //중복되는게 있으면 지움
                    var index = 0
                    //postits for문 돌려서 새로 변경된 녀석의 id값과 지금 배열에 있는 id값이 같으면
                    //해당 내용을 지워라.
                    //클로저라 self로 명확하게 써줘야함
                    for postitItem in self.postits {
                        if (postit.id == postitItem.id) {
                            print(postitItem.id)
                            self.postits.remove(at: index)
                        }
                        index += 1 //인덱스 해당 안되면 인덱스1씩 추가
                    }
                    
                    self.postits.insert(postit, at: 0)
                } catch {
                    print("an error occurred", error)
                }
        }
        
        //.childRemoved 내용이 지워지면 지우기
        databaseReference
            .observe(.childRemoved) {  [weak self] snapshot in
                guard
                    let self = self,
                    var json = snapshot.value as? [String: Any]
                else {
                    return
                }
                
                json["id"] = snapshot.key
                
                do {
                    let postitData = try JSONSerialization.data(withJSONObject: json)
                    let postit = try self.decoder.decode(Postit.self, from: postitData)
                    print(postit)
                    
                    var index = 0
                    for postitItem in self.postits {
                        if (postit.id == postitItem.id) {
                            print(postitItem.id)
                            self.postits.remove(at: index)
                        }
                        index += 1
                    }
                } catch {
                    print("an error occurred", error)
                }
            }
    }
    
    //새로운 포스트잇 받아와서 추가
    func addPostit(postit: Postit) {
        //databaseReference값이 있으면 id를 자동으로 만들고, setValue로 값 넣는데 딕셔너리 형식으로 넣음
        databaseReference?.childByAutoId().setValue([
            "id": postit.id,
            "user": postit.user,
            "memo": postit.memo,
            "colorIndex": postit.colorIndex,
            "createdAt": postit.createdAt
        ])
    }
    
    func deletePostit(postit: Postit) {
        print("delete id: \(postit.id)")
        databaseReference?.child(postit.id).removeValue()
    }
    
    func stopFetching() {
        databaseReference?.removeAllObservers()
    }
}
