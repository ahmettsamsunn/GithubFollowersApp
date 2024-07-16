//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Ahmet Samsun on 14.05.2024.
//

import UIKit
import SafariServices
protocol UserInfoDelegate : AnyObject{
    func didTapGetFollowers(for user : User)
    func didTapGitHubProfile(for user : User)
}

class UserInfoVC: UIViewController {
    let headerview = UIView()
    let itemviewone = UIView()
    let itemviewtwo = UIView()
    var itemviews : [UIView] = []
    var username : String!
    weak var delegate : FollowerListVCDelegate!
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
        Task {
            do {
                let userinfo = try await NetworkManager.shared.getuser(for: username)
                DispatchQueue.main.async {
                    self.configureUIElements(with: userinfo)
                }
                
            }catch {
                self.presentGFAlertOnMainThread(title: "Error", message: "Something went wrong", buttontitle: "Ok")
            }
        }
      
    }
    func configureUIElements(with user : User){
        let repoVC = GFRepoItemVC(user: user)
        repoVC.delegate = self
        
        let followerVC = GFFollowerItemVC(user: user)
        followerVC.delegate = self
        
        self.add(childvc: repoVC, to: self.itemviewone)
        self.add(childvc: followerVC, to: self.itemviewtwo)
        self.add(childvc: GFUserInfoHeaderVC(user: user), to: self.headerview)
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
extension UserInfoVC : UserInfoDelegate {
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No Followers", message: "This user has no followers", buttontitle: "OK")
            return
        }
        delegate.didrequestfollowers(for: user.login)
        dismissVC()
    }
    
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid Url", message: "Url is invalid", buttontitle: "OK")
            return
        }
       presentsafariVC(with: url)
    }
    
   
    
}
