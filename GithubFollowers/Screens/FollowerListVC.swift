//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Ahmet Samsun on 13.03.2024.
//

import UIKit

class FollowerListVC: UIViewController {
    var username : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        NetworkManager.shared.getfollowers(for: username, page: 1) { followers, error in
            guard let followers = followers else {
                self.presentGFAlertOnMainThread(title: "wow wow something went wrong", message: error!, buttontitle: "ok")
                return
            }
            print(followers.count)
            print(followers)
        }
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }



}
