//
//  GFButton.swift
//  GithubFollowers
//
//  Created by Ahmet Samsun on 10.03.2024.
//

import UIKit

class GFButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(backgroundcolor : UIColor , title : String){
        super.init(frame: .zero)
        self.backgroundColor = backgroundcolor
        self.setTitle(title, for: .normal)
        configure()
    }
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }

}
