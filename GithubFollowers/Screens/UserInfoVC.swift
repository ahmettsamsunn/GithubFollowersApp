//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Ahmet Samsun on 14.05.2024.
//

import UIKit

class UserInfoVC: UIViewController {
    let headerview = UIView()
    let itemviewone = UIView()
    let itemviewtwo = UIView()
    var itemviews : [UIView] = []
    var username : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutui()
        configureviewcontroller()
        getUserInfo()
    }
    
    func configureviewcontroller(){
        view.backgroundColor = .systemBackground
        let donebutton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = donebutton
    }
    func getUserInfo(){
        NetworkManager.shared.getuser(for: username) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.add(childvc: GFUserInfoHeaderVC(user: success), to: self.headerview)
                    self.add(childvc: GFRepoItemVC(user: success), to: self.itemviewone)
                    self.add(childvc: GFFollowerItemVC(user: success), to: self.itemviewtwo)
                }
                
            case .failure(let failure):
                self.presentGFAlertOnMainThread(title: "Bir şeyler ters gitti", message: failure.rawValue, buttontitle: "Ok")
            }
        }
    }
    func layoutui(){
        itemviews = [headerview,itemviewone,itemviewtwo]
        for itemview in itemviews {
            view.addSubview(itemview)
            itemview.translatesAutoresizingMaskIntoConstraints = false
        }
   
        
        
        NSLayoutConstraint.activate([
            headerview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerview.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            headerview.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            headerview.heightAnchor.constraint(equalToConstant: 180),
            itemviewone.topAnchor.constraint(equalTo: headerview.bottomAnchor, constant: 20),
            itemviewone.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            itemviewone.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            itemviewone.heightAnchor.constraint(equalToConstant: 140),
            itemviewtwo.topAnchor.constraint(equalTo: itemviewone.bottomAnchor, constant: 20),
            itemviewtwo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            itemviewtwo.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            itemviewtwo.heightAnchor.constraint(equalToConstant: 140),
            
            
        ])
    }
    func add(childvc : UIViewController,to containerView : UIView){
        addChild(childvc)
        containerView.addSubview(childvc.view)
        childvc.view.frame = containerView.bounds
        childvc.didMove(toParent: self)
    }

   @objc func dismissVC(){
        dismiss(animated: true)
    }

}
