//
//  GFAvatarImageView.swift
//  GithubFollowers
//
//  Created by Ahmet Samsun on 19.04.2024.
//

import UIKit

class GFAvatarImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true
        image = UIImage(named: "avatar-placeholder")
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadimage(from UrlString : String) {
        guard let url = URL(string: UrlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else {return}
            if error != nil {
                return
            }
            guard let data = data else {return}
            
            guard let image = UIImage(data: data) else {return}
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
