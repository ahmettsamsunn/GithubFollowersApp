//
//  GFRepoItemVC.swift
//  GithubFollowers
//
//  Created by Ahmet Samsun on 5.07.2024.
//

import UIKit

class GFRepoItemVC : GFItemInfoVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureitems()
    }
    private func configureitems(){
        itemInfoViewOne.set(itemInfoType: .repos, withcount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gits, withcount: user.publicGists)
        actionbutton.set(background: .systemPurple, title: "GitHub Profile")
    }
    override func actionbuttontapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}
