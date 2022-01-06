//
//  CommentView.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/06.
//

import UIKit
import SnapKit

class CommentView: UIView, CustomViewProtocol {
    
    let commentUserNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let commentTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let settingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .gray
        return button
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
        self.addSubview(commentUserNameLabel)
        self.addSubview(commentTextLabel)
        self.addSubview(settingButton)
    }
    
    func makeConstraints() {
        settingButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(20)
            $0.width.equalTo(settingButton.snp.height).multipliedBy(1.0)
        }
        
        commentUserNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalTo(settingButton.snp.leading).inset(10)
        }
        
        commentTextLabel.snp.makeConstraints {
            $0.top.equalTo(commentUserNameLabel).offset(20)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalTo(settingButton.snp.leading).inset(10)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    
    func fetchData(_ data: Comment) {
        commentUserNameLabel.text = "\(data.id)"
        commentTextLabel.text = data.comment
    }
}
