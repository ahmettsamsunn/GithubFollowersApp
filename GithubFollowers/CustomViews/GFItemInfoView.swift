//
//  GFItemInfoView.swift
//  GithubFollowers
//
//  Created by Ahmet Samsun on 4.07.2024.
//

import UIKit

enum ItemInfoType{
    case repos,gits,followers,following
}

class GFItemInfoView: UIView {

   let symbolimageview = UIImageView()
    let titlelabel = GFTitleLabel(textAligment: .left, fontSize: 14)
    let countlabel = GFTitleLabel(textAligment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        addSubview(symbolimageview)
        addSubview(titlelabel)
        addSubview(countlabel)
        symbolimageview.translatesAutoresizingMaskIntoConstraints = false
        symbolimageview.contentMode = .scaleAspectFill
        symbolimageview.tintColor = .label
        
        NSLayoutConstraint.activate([
            symbolimageview.topAnchor.constraint(equalTo: topAnchor),
            symbolimageview.leftAnchor.constraint(equalTo: leftAnchor),
            symbolimageview.widthAnchor.constraint(equalToConstant: 20),
            symbolimageview.heightAnchor.constraint(equalToConstant: 20),
            
            titlelabel.centerYAnchor.constraint(equalTo: symbolimageview.centerYAnchor),
            titlelabel.leftAnchor.constraint(equalTo: symbolimageview.rightAnchor,constant: 12),
            titlelabel.rightAnchor.constraint(equalTo: rightAnchor),
            titlelabel.heightAnchor.constraint(equalToConstant: 18),
            
            countlabel.topAnchor.constraint(equalTo: symbolimageview.bottomAnchor,constant: 4),
            countlabel.leftAnchor.constraint(equalTo: leftAnchor),
            countlabel.rightAnchor.constraint(equalTo: rightAnchor),
            countlabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    func set(itemInfoType : ItemInfoType,withcount count : Int){
        switch itemInfoType {
        case .repos:
            symbolimageview.image = UIImage(systemName: "folder")
            titlelabel.text = "Public Repos"
        case .gits:
            symbolimageview.image = UIImage(systemName: "text.alignleft")
            titlelabel.text = "Public Gits"
        case .followers:
            symbolimageview.image = UIImage(systemName: "heart")
            titlelabel.text = "Followers"
        case .following:
            symbolimageview.image = UIImage(systemName: "person.2")
            titlelabel.text = "Following"
        }
        countlabel.text = String(count)
    }
}
