//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Ahmet Samsun on 13.04.2024.
//

import Foundation
class NetworkManager{
    static let shared = NetworkManager()
    private init() {
        
    }
    let baseurl = "https://api.github.com/"
    func getfollowers(for username : String , page : Int , completed : @escaping([Follower]?,String?) -> Void) {
        let endpoint =  baseurl + "users/\(username)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endpoint) else {
            completed(nil,"error1")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(nil,"error2")
            }
            guard let data = data else {
                completed(nil,"error3")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers,nil)
            } catch {
                completed(nil,"error4")
            }
        }
        
        
        task.resume()
    }
}
