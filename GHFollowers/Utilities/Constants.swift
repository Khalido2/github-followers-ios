//
//  Constants.swift
//  GHFollowers
//
//  Created by "Khalid Olowe-Makorie, Vodafone" on 11/10/2024.
//

import UIKit

enum SFSymbols {
    static let location = UIImage(systemName: "mappin.and.ellipse")
    static let repos = UIImage(systemName: "folder")
    static let gists = UIImage(systemName: "text.alignleft")
    static let followers = UIImage(systemName: "heart")
    static let following = UIImage(systemName: "person.2")
}

enum PersistenceKeys {
    static let favourites = "favourites"
}

enum DeviceTypes {
    
    static let isiPhoneSE = UIDevice.current.model.contains("SE")
}

enum Images {
    static let logo = "gh-logo"
    static let placeholderImage = "avatar-placeholder"
    static let emptyStateLogo = "empty-state-logo"
}
