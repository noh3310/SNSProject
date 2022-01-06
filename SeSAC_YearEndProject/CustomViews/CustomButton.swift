//
//  CustomButton.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/02.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .seSACColor
        self.layer.cornerRadius = 5
        self.tintColor = .white
        
        self.snp.makeConstraints {
            $0.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
