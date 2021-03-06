//
//  SceneDelegate.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/02.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        
        let jwt = UserDefaults.standard.string(forKey: "token") ?? nil
        let id = UserDefaults.standard.string(forKey: "id")
        let password = UserDefaults.standard.string(forKey: "password")
        let signUpState = UserDefaults.standard.bool(forKey: "signUp")
        
        var vc: UIViewController = UIViewController()
        // 회원가입 안했으면 회원가입 화면으로 변경
        if !signUpState {
            vc = SignUpViewController()
        } else if signUpState && (jwt == nil) { // 회원가입은 했는데 토큰이 없다면 ㄹ그인으로 이동
            vc = SignInViewController()
        } else {    // 토큰이 있으면 홈화면으로 넘어간 후 만약 만료되었다면 다시 로그인으로 이동
            vc = BoardViewController()
        }


        let nav = UINavigationController(rootViewController: vc)
        // 루트뷰 컨트롤러 설정
        window?.rootViewController = nav
        // iOS 13에서 생긴 메서드
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

