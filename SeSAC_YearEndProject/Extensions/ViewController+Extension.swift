//
//  ViewController+Extension.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/13.
//

import UIKit

extension UIViewController {
     static func gotoLogin() {
         let rootVC = UINavigationController(rootViewController: SignInViewController())
         let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
         sceneDelegate.window?.rootViewController = rootVC
    }
}
