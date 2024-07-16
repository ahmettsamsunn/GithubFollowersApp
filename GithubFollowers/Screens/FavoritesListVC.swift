//
//  FavoritesListVC.swift
//  GithubFollowers
//
//  Created by Ahmet Samsun on 10.03.2024.
//

import UIKit
    
class FavoritesListVC: UIViewController {
    let tableview = UITableView()
    var favorites :  [Follower] = []
    var username : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
      configureTableView()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    func configureView(){
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func configureTableView(){
        view.addSubview(tableview)
        tableview.frame = view.bounds
        tableview.rowHeight = 80
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(FavoriteCell.self, forCellReuseIdentifier: "FavoriteCell")
    }
    func getFavorites(){
        PersistanceManager.retrieveFavorites { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let favorites):
                if favorites.isEmpty {
                    self.showemptystatesview(with: "Your favorites list is empty. You might want to add some people.", in: self.view)
                }else {
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableview.reloadData()
                    }
                }
                
            case .failure(let failure):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: failure.localizedDescription, buttontitle: "Ok")            }
        }
    }
    

}
extension FavoritesListVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell") as! FavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destVC = FollowerListVC()
        destVC.username = favorite.login
        destVC.title = favorite.login
        navigationController?.pushViewController(destVC, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistanceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else {
                return
            }
            guard let error = error else {
                return
            }
            self.presentGFAlertOnMainThread(title: "User could not be deleted", message: error.rawValue, buttontitle: "Ok")
        }
    }
}
