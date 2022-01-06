//
//  PostView.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/06.
//

import UIKit

class PostDetailView: UIView, CustomViewProtocol {
    
    let scrollView: UIScrollView =  {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemGray6
        return scrollView
    }()
    
    
    let userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star")
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "aaaaa"
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "bbb"
        return label
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
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
    
    let commentView = InputCommentView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        self.addSubview(scrollView)
//        scrollView.addSubview(contentView)
        scrollView.addSubview(userImage)
        scrollView.addSubview(userNameLabel)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(textLabel)
        scrollView.addSubview(divideLine)
        scrollView.addSubview(commentStackView)
        self.addSubview(commentView)
    }
    
    func makeConstraints() {
        commentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(super.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(commentView.snp.top).inset(20)
            $0.centerX.equalToSuperview()
        }
        
        userImage.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
            $0.height.equalTo(40)
            $0.width.equalTo(userImage.snp.height).multipliedBy(1.0)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(userImage.snp.top)
            $0.leading.equalTo(userImage.snp.trailing).offset(20)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(userNameLabel)
        }
        
        textLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        divideLine.snp.makeConstraints {
            $0.top.equalTo(textLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(1)
        }
        
        commentStackView.snp.makeConstraints {
            $0.top.equalTo(divideLine.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
        }
    }
    
    func fetchData(_ data: Bearer) {
        userNameLabel.text = data.user.username
        dateLabel.text = data.updatedAt
        commentLabel.text = "댓글 \(data.comments.count)"
        textLabel.text =  data.text
        
        let count = data.comments.count
        var prevView: UIView = commentStackView
        
        var viewList = [CommentView]()
        if count == 0 {
            commentStackView.snp.makeConstraints {
                $0.bottom.equalToSuperview().inset(10)
            }
        }
        
        for index in data.comments.indices {
            print(index)
            let view = commentView(data.comments[index])
            viewList.append(view)
            scrollView.addSubview(view)
            view.snp.makeConstraints {
                $0.top.equalTo(prevView.snp.bottom).offset(30)
                $0.leading.trailing.equalToSuperview()
                if count - 1 == index {
                    $0.bottom.equalToSuperview().inset(20)
                }
            }
            prevView = view
        }
    }

    func commentView(_ data: Comment) -> CommentView {
        let comment = CommentView()
        comment.fetchData(data)
        return comment
    }
}
