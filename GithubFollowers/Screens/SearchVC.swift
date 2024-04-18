//
//  SearchVC.swift
//  GithubFollowers
//
//  Created by Ahmet Samsun on 10.03.2024.
//

import UIKit

class SearchVC: UIViewController {
    let logoimageview = UIImageView()
    let usernametextfield = GFTextField()
    let callToactionbutton = GFButton(backgroundcolor: .systemGreen, title: "Get Followers")
    
    var isusernameentered : Bool {
        return !usernametextfield.text!.isEmpty
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCalltoActionButton()
        createdismisskeyboardtapgesture()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    @objc func pushFollowerListVC(){
        guard isusernameentered else {
            presentGFAlertOnMainThread(title: "Empty Username", message: "Please entry a username", buttontitle: "OK")
            return
            }
        let followerlistvc = FollowerListVC()
        followerlistvc.username = usernametextfield.text
        followerlistvc.title = usernametextfield.text
        navigationController?.pushViewController(followerlistvc, animated: true)
    }
    func createdismisskeyboardtapgesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    func configureLogoImageView(){
        view.addSubview(logoimageview)
        logoimageview.translatesAutoresizingMaskIntoConstraints = false
        logoimageview.image = UIImage(named: "gh-logo")
        NSLayoutConstraint.activate([
            logoimageview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 80),
            logoimageview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoimageview.heightAnchor.constraint(equalToConstant: 200),
            logoimageview.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    func configureTextField(){
        view.addSubview(usernametextfield)
        NSLayoutConstraint.activate([
            
            usernametextfield.topAnchor.constraint(equalTo: logoimageview.bottomAnchor,constant: 40),
            usernametextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
            usernametextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernametextfield.heightAnchor.constraint(equalToConstant: 50)
            
    ])
    }
    func configureCalltoActionButton(){
        view.addSubview(callToactionbutton)
        callToactionbutton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            callToactionbutton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToactionbutton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToactionbutton.trailingAnchor.constraint(equalTo:  view.trailingAnchor, constant: -50),
            callToactionbutton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
