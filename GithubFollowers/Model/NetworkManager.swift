//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Ahmet Samsun on 13.04.2024.
//

import UIKit
class NetworkManager{
    static let shared = NetworkManager()
    let cache = NSCache<NSString,UIImage>()
    private init() {
        
    }
    let baseurl = "https://api.github.com/"
  /*
   func getfollowers(for username : String , page : Int , completed : @escaping(Result<[Follower],ErrorMessage>) -> Void) {
        let endpoint =  baseurl + "users/\(username)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData) )
            }
        }
        
        
        task.resume()
  } */
    
   func getfollowers(for username : String , page : Int ) async throws -> [Follower] {
          let endpoint =  baseurl + "users/\(username)/followers?per_page=100&page=\(page)"
          guard let url = URL(string: endpoint) else {
              throw ErrorMessage.invalidUsername
              
          }
        let (data,response) = try await URLSession.shared.data(from: url)
          
              do {
                  let decoder = JSONDecoder()
                  decoder.keyDecodingStrategy = .convertFromSnakeCase
                  return try decoder.decode([Follower].self, from: data)
              } catch {
                  throw ErrorMessage.invalidData
              }
          } 
          
          
          
    
    
    func getuser(for username : String ) async throws -> User {
        let endpoint =  baseurl + "users/\(username)"
        guard let url = URL(string: endpoint) else {
            throw ErrorMessage.invalidResponse
        }
        
        let (data,response) = try await URLSession.shared.data(from: url)
       
           
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
               return try decoder.decode(User.self, from: data)
                
            } catch {
                throw ErrorMessage.invalidData
            }
        }
        
        
       
    
}
