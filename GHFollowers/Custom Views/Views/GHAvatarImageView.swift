//
//  GHAvatarImageView.swift
//  GHFollowers
//
//  Created by "Khalid Olowe-Makorie, Vodafone" on 08/10/2024.
//

import UIKit

class GHAvatarImageView: UIImageView {
    
    let placeholderImage = Images.placeholderImage
    let cache = NetworkManager.shared.avatarCache

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadAvatarImage(fromURL url: String) {
        Task {
            image = await NetworkManager.shared.downloadImage(from: url) ?? placeholderImage
        }
    }
}
