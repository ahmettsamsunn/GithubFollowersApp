//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Ahmet Samsun on 13.03.2024.
//

import UIKit

class FollowerListVC: UIViewController {
    enum Section {
        case main
    }
    var username : String!
    var collectioview : UICollectionView!
    var followers : [Follower] = []
    var datasource : UICollectionViewDiffableDataSource<Section,Follower>!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureCollectionView()
        configureDataSource()
        getFollowers()
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func getFollowers(){
        NetworkManager.shared.getfollowers(for: username, page: 1) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let followers):
                self.followers = followers
                self.updateData()
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bir terlik var...", message: error  .rawValue, buttontitle: "ok")
            }
        }
    }
   
    
    func configureCollectionView(){
        collectioview = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColoumnFlowLayout(in: view))
        view.addSubview(collectioview)
        collectioview.backgroundColor = .systemBackground
        collectioview.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.identifier)
    }
    
    
    func configureDataSource(){
        datasource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectioview, cellProvider: { (collectionview, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionview.dequeueReusableCell(withReuseIdentifier: FollowerCell.identifier, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    
    func updateData(){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        datasource.apply(snapshot,animatingDifferences: true)
    }
}
