//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Ahmet Samsun on 13.03.2024.
//

import UIKit

protocol FollowerListVCDelegate : AnyObject {
    func didrequestfollowers(for username : String)
}

class FollowerListVC: UIViewController {
    enum Section {
        case main
    }
    var username : String!
    var collectioview : UICollectionView!
    var followers : [Follower] = []
    var filterfollowers : [Follower] = []
    var isSearching = false
    var page = 1
    var hasmorefollowers = true
    var datasource : UICollectionViewDiffableDataSource<Section,Follower>!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureCollectionView()
        configuresearchcontroller()
        configureDataSource()
        getFollowers(username: username, page: page)
        
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        let addbutton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addbuttontapped))
        navigationItem.rightBarButtonItem = addbutton
    }
    
    
 /*  func getFollowers(username : String,page : Int){
        showloadingview()
        NetworkManager.shared.getfollowers(for: username, page: page) { [weak self] result in
            
            guard let self = self else {return}
            self.dismissloadingview()
            switch result {
            case .success(let followers):
                updateUI(with: followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bir terlik var...", message: error  .rawValue, buttontitle: "ok")
            }
        }
    }*/
    
   func getFollowers(username : String,page : Int){
        showloadingview()
        hasmorefollowers = true

        Task {
            do {
                let followers = try await NetworkManager.shared.getfollowers(for: username, page: page)
                updateUI(with: followers)
                dismissloadingview()
            } catch {
                if let gferror = error as? ErrorMessage {
                    presentGFAlertOnMainThread(title: "hata1", message: "hata2", buttontitle: "tamam")
                }else {
                    presentGFAlertOnMainThread(title: "tamam", message: "tamam", buttontitle: "tamam")
                }
                dismissloadingview()
            }
        }
    }
   
    func updateUI(with followers : [Follower]) {
        if  followers.count < 100 {self.hasmorefollowers = false}
        self.followers.append(contentsOf: followers)
        if self.followers.isEmpty {
            let message = " Kullanıcının hiç takipçisi yok 🥲.hBelki sen takip etmek isteyebilirsin. "
            DispatchQueue.main.async {
                self.showemptystatesview(with: message, in: self.view)
            }
            
        }
        self.updateData(on: self.followers)
    }

    @objc func addbuttontapped(){
        showloadingview()
        
        func getUserInfo(){
            self.dismissloadingview()
            Task {
                do {
                    let userinfo = try await NetworkManager.shared.getuser(for: username)
                    let favorite = Follower(login: userinfo.login, avatarUrl: userinfo.avatarUrl)
                    PersistanceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                        guard let self = self else {
                            return
                        }
                        guard let error = error else {
                            self.presentGFAlertOnMainThread(title: "Tebrikler", message: "Kullanıcı başarıyla favorilerinize eklendi", buttontitle: "Tamam")
                            return
                        }
                        self.presentGFAlertOnMainThread(title: "Hata", message:error.rawValue, buttontitle: "Tamam")
                    }
                    
                }catch {
                    self.presentGFAlertOnMainThread(title: "Hata", message: "Bir şeyler ters gitti", buttontitle: "Ok")
                }
            }
          
        }

    }
    
    
    func configureCollectionView(){
        collectioview = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColoumnFlowLayout(in: view))
        view.addSubview(collectioview)
        collectioview.delegate = self
        collectioview.backgroundColor = .systemBackground
        collectioview.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.identifier)
    }
    
    func configuresearchcontroller(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Bir kullanıcı arayın"
        searchController.obscuresBackgroundDuringPresentation = true
        navigationItem.searchController = searchController
    }
    
    func configureDataSource(){
        datasource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectioview, cellProvider: { (collectionview, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionview.dequeueReusableCell(withReuseIdentifier: FollowerCell.identifier, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    
    func updateData(on followers : [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        datasource.apply(snapshot,animatingDifferences: true)
    }
}
extension FollowerListVC : UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsety = scrollView.contentOffset.y
        let contenheight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        guard hasmorefollowers else {return}
        if offsety > contenheight - height {
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activearray = isSearching ? filterfollowers : followers
        let follower = activearray[indexPath.item]
        let destvc = UserInfoVC()
        destvc.delegate = self
        let navController = UINavigationController(rootViewController: destvc)
        destvc.username = follower.login
        present(navController, animated: true)
    }
   
}
extension FollowerListVC : UISearchResultsUpdating,UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text,!filter.isEmpty else {
            return
        }
        isSearching = true
        filterfollowers = followers.filter {$0.login.lowercased().contains(filter.lowercased())}
        
        updateData(on: filterfollowers)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: followers)
        isSearching = false
    }
    
    
}
extension FollowerListVC : FollowerListVCDelegate {
    func didrequestfollowers(for username: String) {
        self.username = username
        title = username
        followers.removeAll()
        page = 1
        collectioview.setContentOffset(.zero, animated: true)
        getFollowers(username: username, page: page)
    }
    
    
}

