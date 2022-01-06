//
//  BoardView.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/04.
//

import UIKit

class BoardView: UIView, CustomViewProtocol {

    let tableView = UITableView()
    
    let editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .seSACColor
        button.layer.cornerRadius = 30
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        addViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        self.addSubview(tableView)
        self.addSubview(editButton)
    }
    
    func makeConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        editButton.snp.makeConstraints {
            $0.trailing.bottom.equalTo(super.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(60)
            $0.width.equalTo(editButton.snp.height).multipliedBy(1.0)
        }
    }
}
