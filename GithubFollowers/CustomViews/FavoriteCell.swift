//
//  FavoriteCell.swift
//  GithubFollowers
//
//  Created by Ahmet Samsun on 14.07.2024.
//

import UIKit

class FavoriteCell: UITableViewCell {

    
    static let identifier = "FavoriteCell"
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAligment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func set(favorite : Follower){
        usernameLabel.text = favorite.login
        avatarImageView.downloadimage(from: favorite.avatarUrl)
    }
    private func configure(){
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        accessoryType = .disclosureIndicator
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
           
            avatarImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 24),
            usernameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
