//
//  CommentTableViewCell.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/12.
//

import UIKit
import RxSwift

class CommentTableViewCell: UITableViewCell, CustomViewProtocol {
    
    static let identifier = "CommentTableViewCell"
    
    var disposeBag = DisposeBag()
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        
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
            $0.top.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(20)
            $0.width.equalTo(settingButton.snp.height).multipliedBy(1.0)
        }
        
        commentUserNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(settingButton.snp.leading).inset(-10)
        }
        
        commentTextLabel.snp.makeConstraints {
            $0.top.equalTo(commentUserNameLabel).offset(30)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(settingButton.snp.leading).inset(-10)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    
}
