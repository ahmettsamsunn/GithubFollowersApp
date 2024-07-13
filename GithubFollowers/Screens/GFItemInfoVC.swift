//
//  GFItemInfoVC.swift
//  GithubFollowers
//
//  Created by Ahmet Samsun on 5.07.2024.
//

import UIKit

class GFItemInfoVC: UIViewController {
let stackview = UIStackView()
let itemInfoViewOne = GFItemInfoView()
let itemInfoViewTwo = GFItemInfoView()
let actionbutton = GFButton()
   weak var delegate : UserInfoDelegate!
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
            configureView()
            layoutui()
            configurestackview()
            configureactionbutton()
            }
    

    func configureView(){
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
   private func configureactionbutton(){
        actionbutton.addTarget(self, action: #selector(actionbuttontapped), for: .touchUpInside)
    }
    @objc func actionbuttontapped(){
        
    }
    private func configurestackview(){
        stackview.axis = .horizontal
        stackview.distribution = .equalSpacing
        stackview.addArrangedSubview(itemInfoViewOne)
        stackview.addArrangedSubview(itemInfoViewTwo)
    }
    func layoutui(){
        view.addSubview(stackview)
        view.addSubview(actionbutton)
        stackview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackview.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackview.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackview.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            stackview.heightAnchor.constraint(equalToConstant: 50),
            actionbutton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            actionbutton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            actionbutton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            actionbutton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
