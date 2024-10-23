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
    let decoder = JSONDecoder()
    
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    //for the escaping its that the completed will output either an array of Follower if it succeeds or a string for an error if it fails
    //both optional as it might be either or
    func getFollowers(for username: String, page: Int) async throws -> [Follower] {
        let endpoint = baseURL + "\(username)/followers?per_page=\(NetworkManager.itemsPerPage)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            throw GHError.invalidUsername
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        
        do {
            return try decoder.decode([Follower].self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
    
    func getUserInfo(for username: String) async throws -> User {
        let endpoint = baseURL + "\(username)"
        
        guard let url = URL(string: endpoint) else {
            throw GHError.invalidUsername
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        
        do {
            return try decoder.decode(User.self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
    
    func downloadImage(from urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        
        if let image = avatarCache.object(forKey: cacheKey){
            return image
        }

        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else {return nil}
            avatarCache.setObject(image, forKey: NSString(string: urlString))
            return image
        } catch {
            return nil
        }
    }
}
