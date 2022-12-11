//
//  AuthViewModel.swift
//  TestDemo
//
//  Created by Deokhun KIM on 2022/12/08.
//

import Firebase
import GoogleSignIn

class AuthenticationViewModel: ObservableObject {

  // 1. 구글 로그인, 로그아웃 상태를 정의하는 enum
  enum SignInState {
    case signedIn
    case signedOut
  }

  // 2. @Published: 인증 상태를 관리하는 변수
  @Published var state: SignInState = .signedOut
  
    func signIn() {
      // 1. 이전 로그인이 있는지 확인, 로그인 안되어있으면 로그인 프로세스로 이동
      if GIDSignIn.sharedInstance.hasPreviousSignIn() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
            authenticateUser(for: user, with: error)
        }
      } else {
        // 2 FirebaseApp에서 GoogleService-Info.plistclientID 가져옴
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // 3. clientID로  Google 로그인 구성 개체를 만듬
        let configuration = GIDConfiguration(clientID: clientID)
        
        // 4. View controllers를 사용하여 presentingViewController를 검색하지 않으니 UIApplication의 공유 인스턴스를 통해 액세스함. 이제 UIWindow를 직접 사용하는 것은 더 이상 사용되지 않으며, 대신 rootViewController를 사용해야 함.
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
        
        // 5. GIDSignIn 클래스의 공유 인스턴스에서 signIn()을 호출하여 로그인 프로세스를 시작합니다. 구성 개체와 제시 컨트롤러를 전달합니다.
        GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { [unowned self] user, error in
          authenticateUser(for: user, with: error)
        }
      }
    }
    
    //이제 GIDGoogleUser에 액세스할 수 있으므로 Firebase Auth에도 로그인할 수 있음.
    private func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
      // 1. 오류처리
      if let error = error {
        print(error.localizedDescription)
        return
      }
      
      // 2. user 인스턴스에서 idToken과 accessToken을 받음
      guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
      
      let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
      
      // 3. Firebase에 로그인. 오류가 없으면 상태를 signedIn 으로 변경
      Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
        if let error = error {
          print(error.localizedDescription)
        } else {
          self.state = .signedIn
        }
      }
    }
    
    //위 프로세스와 마찬가지로 signOut()메소드를 호출. 또한 메서드를 호출하는 Firebase 앱에서 인증을 관리하는 개체를 가져옵니다 signOut(). 오류가 없으면 상태를 다음으로 변경합니다.signedOut.
    func signOut() {
      // 1
      GIDSignIn.sharedInstance.signOut()
      
      do {
        // 2
        try Auth.auth().signOut()
        
        state = .signedOut
      } catch {
        print(error.localizedDescription)
      }
    }
}
