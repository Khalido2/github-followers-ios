//
//  Follower.swift
//  GHFollowers
//
//  Created by "Khalid Olowe-Makorie, Vodafone" on 04/10/2024.
//

import Foundation

//when using codable, the struct variables must match the json response of the api

struct Follower: Codable {
    var login: String
    var avatarUrl: String
}
