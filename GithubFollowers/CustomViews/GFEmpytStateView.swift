//
//  GFEmpytStateView.swift
//  GithubFollowers
//
//  Created by Ahmet Samsun on 24.04.2024.
//

import UIKit

class GFEmpytStateView: UIView {
    let messagelabe = GFTitleLabel(textAligment: .center, fontSize: 28)
    let imageview  = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(message:String){
        super.init(frame: .zero)
        messagelabe.text = message
        configure()
    }
    func configure(){
        addSubview(messagelabe)
        addSubview(imageview)
        
        messagelabe.numberOfLines = 3
        messagelabe.textColor = .secondaryLabel
        imageview.image = UIImage(named: "empty-state-logo")
        imageview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messagelabe.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -140),
            messagelabe.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40),
            messagelabe.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -40),
            messagelabe.heightAnchor.constraint(equalToConstant: 200),
            imageview.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            imageview.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            imageview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 200),
            imageview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 120)
        ])
    }
}
