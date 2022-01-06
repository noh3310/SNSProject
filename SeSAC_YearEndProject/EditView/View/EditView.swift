//
//  EditView.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/06.
//

import UIKit
import SnapKit

class EditView: UIView, CustomViewProtocol {
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 20)
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        self.addSubview(textView)
    }
    
    func makeConstraints() {
        textView.snp.makeConstraints {
            $0.edges.equalTo(super.safeAreaLayoutGuide)
        }
    }
}
