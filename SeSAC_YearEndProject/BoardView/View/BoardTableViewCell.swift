//
//  BoardTableViewCell.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/04.
//

import UIKit
import SnapKit

class BoardTableViewCell: UITableViewCell, CustomViewProtocol {
    
    static let identifier = "BoardTableViewCell"
    
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGray4
        label.layer.cornerRadius = 5
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let divideLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private let commentImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "bubble.right")
        image.tintColor = .gray
        return image
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "댓글 쓰기"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    let commentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .systemGray6
        
        setStackView()
        
        addViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setStackView() {
        commentStackView.addArrangedSubview(commentImage)
        commentStackView.addArrangedSubview(commentLabel)
    }
    
    func addViews() {
        self.addSubview(view)
        view.addSubview(nicknameLabel)
        view.addSubview(contentLabel)
        view.addSubview(dateLabel)
        view.addSubview(divideLine)
        view.addSubview(commentStackView)
    }
    
    func makeConstraints() {
        view.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(20)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
        }
        
        divideLine.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
        
        commentStackView.snp.makeConstraints {
            $0.top.equalTo(divideLine.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
}
