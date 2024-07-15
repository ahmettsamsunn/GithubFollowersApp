//
//  PersistanceManager.swift
//  GithubFollowers
//
//  Created by Ahmet Samsun on 13.07.2024.
//

import Foundation

enum PersistanceAction{
    case add,remove
}
enum PersistanceManager {
    static private let defaults = UserDefaults.standard
    
    static func updateWith(favorite : Follower,actionType : PersistanceAction,completed : @escaping(ErrorMessage?) -> Void){
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var newfavorites = favorites
                switch actionType {
                case .add:
                    guard !newfavorites.contains(favorite) else {
                        completed(.alreadyinfavorites)
                        return
                    }
                    newfavorites.append(favorite)
                case .remove:
                    newfavorites.removeAll {$0.login == favorite.login}
                }
                completed(save(favorites: newfavorites))
            case .failure(let failure):
                completed(failure)
            }
        }
    }
    
    static func retrieveFavorites(completed : @escaping(Result<[Follower], ErrorMessage>) -> Void){
        guard let favoritesdata = defaults.object(forKey: "favorites") as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesdata)
            completed(.success(favorites))
        } catch {
            completed(.failure(.invalidData) )
        }

    }
    static func save(favorites : [Follower]) -> ErrorMessage? {
        do {
            let encoder = JSONEncoder()
            let encodedfavorites = try encoder.encode(favorites)
            defaults.set(encodedfavorites, forKey: "favorites")
            return nil
        } catch {
            return .invalidData
        }
        
        
        
        return nil
    }
}
