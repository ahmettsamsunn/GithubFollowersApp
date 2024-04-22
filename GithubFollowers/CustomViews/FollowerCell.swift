//
//  FollowerCell.swift
//  GithubFollowers
//
//  Created by Ahmet Samsun on 19.04.2024.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    static let identifier = "FollowerCell"
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAligment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func set(follower : Follower){
        usernameLabel.text = follower.login
        avatarImageView.downloadimage(from: follower.avatarUrl)
    }
    private func configure(){
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            avatarImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            avatarImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            usernameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
            
        
        ])
    }
}
