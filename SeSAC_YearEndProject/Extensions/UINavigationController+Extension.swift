//
//  NavigationBar+Extension.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/06.
//

import UIKit

extension UINavigationController {
    func setBackButton() {
        self.navigationBar.topItem?.title = ""
        self.navigationBar.tintColor = .black
    }
}
