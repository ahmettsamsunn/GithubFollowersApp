//
//  GFUserInfoHeaderVC.swift
//  GithubFollowers
//
//  Created by Ahmet Samsun on 15.05.2024.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
    let avatarimage = GFAvatarImageView(frame: .zero)
    let uasenamenamelabel = GFTitleLabel(textAligment: .left, fontSize: 34)
    let namelabel = GFSecondaryTitleLabel(fontsize: 18)
    let locationimageview = UIImageView()
    let locationlabel = GFSecondaryTitleLabel(fontsize: 18)
    let biolabel = GFBodyLabel(textAligment: .left)
    var user : User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addsubview()
        layoutui()
        configure()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    func configure(){
        avatarimage.downloadimage(from: user.avatarUrl)
        uasenamenamelabel.text = user.login
        namelabel.text = user.name ?? "bilinmiyor"
        locationlabel.text = user.location ?? "?hghjhjg?"
        biolabel.text = user.bio 
        locationimageview.image = UIImage(systemName: SFSymbols.location)
        locationimageview.tintColor = .secondaryLabel
    }
    func addsubview(){
        view.addSubview(avatarimage)
        view.addSubview(uasenamenamelabel)
        view.addSubview(namelabel)
        view.addSubview(locationimageview)
        view.addSubview(locationlabel)
        view.addSubview(biolabel)
    }
    func layoutui(){
        let padding : CGFloat = 20
        let textimagepadding : CGFloat = 20
        locationimageview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarimage.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarimage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            avatarimage.widthAnchor.constraint(equalToConstant: 90),
            avatarimage.heightAnchor.constraint(equalToConstant: 90),
            uasenamenamelabel.topAnchor.constraint(equalTo: avatarimage.topAnchor),
            uasenamenamelabel.leftAnchor.constraint(equalTo: avatarimage.rightAnchor,constant: textimagepadding),
            uasenamenamelabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
            uasenamenamelabel.heightAnchor.constraint(equalToConstant: 38),
            namelabel.centerYAnchor.constraint(equalTo: avatarimage.centerYAnchor, constant: 8),
            namelabel.leftAnchor.constraint(equalTo: avatarimage.rightAnchor, constant: textimagepadding),
            namelabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
            namelabel.heightAnchor.constraint(equalToConstant: 20),
            locationimageview.bottomAnchor.constraint(equalTo: avatarimage.bottomAnchor),
            locationimageview.leftAnchor.constraint(equalTo: avatarimage.rightAnchor, constant: textimagepadding),
            locationimageview.widthAnchor.constraint(equalToConstant: 20),
            locationimageview.heightAnchor.constraint(equalToConstant: 20),
            locationlabel.centerYAnchor.constraint(equalTo: locationimageview.centerYAnchor),
            locationlabel.leftAnchor.constraint(equalTo: locationimageview.rightAnchor, constant: 5),
            locationlabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
            locationlabel.heightAnchor.constraint(equalToConstant: 20),
            biolabel.topAnchor.constraint(equalTo: avatarimage.bottomAnchor, constant: textimagepadding),
            biolabel.leftAnchor.constraint(equalTo: avatarimage.leftAnchor),
            biolabel.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -padding),
            biolabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
