//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by "Khalid Olowe-Makorie, Vodafone" on 15/10/2024.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    static func update(with favourite: Follower, actionType: PersistenceActionType, completed: @escaping (GHError?) -> Void ) {
        retrieveFavourites { result in
            
            switch result {
            case .success(var favourites):
                
                switch actionType {
                case .add:
                    guard !favourites.contains(favourite) else {
                        completed(.alreadyInFavourites)
                        return
                    }
                    
                    favourites.append(favourite)
                    
                case .remove:
                    favourites.removeAll { $0.login == favourite.login }
                }
                
                completed(saveFavourites(favourites: favourites))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveFavourites(completed: @escaping (Result<[Follower], GHError>) -> Void) {
        guard let favouritesData = defaults.object(forKey: PersistenceKeys.favourites) as? Data else {
            //in this case there are no favourites aka favourites data is nil
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favourites = try decoder.decode([Follower].self, from: favouritesData)
            completed(.success(favourites))
        } catch {
            completed(.failure(.unableToFavourite))
        }
    }
    
    static func saveFavourites(favourites: [Follower]) -> GHError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavs = try encoder.encode(favourites)
            defaults.set(encodedFavs, forKey: PersistenceKeys.favourites)
            
            return nil
            
        } catch {
            return .unableToFavourite
        }
    }
}
