//
//  UITextField+Extension.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/02.
//

import UIKit

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
