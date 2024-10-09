//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by "Khalid Olowe-Makorie, Vodafone" on 04/10/2024.
//

//Singleton
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    static let itemsPerPage: Int = 100
    
    private let baseURL = "https://api.github.com/users/"
    let avatarCache = NSCache<NSString, UIImage>() //cache for the avatars
    
    private init() {}
    
    //for the escaping its that the completed will output either an array of Follower if it succeeds or a string for an error if it fails
        //both optional as it might be either or
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GHError>) -> Void) {
        let endpoint = baseURL + "\(username)/followers?per_page=\(NetworkManager.itemsPerPage)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
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
                 completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
