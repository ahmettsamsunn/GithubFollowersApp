//
//  GFFollowerItemVC.swift
//  GithubFollowers
//
//  Created by Ahmet Samsun on 6.07.2024.
//

import UIKit

class GFFollowerItemVC : GFItemInfoVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureitems()
    }
    private func configureitems(){
        itemInfoViewOne.set(itemInfoType: .followers, withcount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withcount: user.following)
        actionbutton.set(background: .systemGreen, title: "Get Followers")
    }
    override func actionbuttontapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
