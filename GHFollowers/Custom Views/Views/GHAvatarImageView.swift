//
//  GHAvatarImageView.swift
//  GHFollowers
//
//  Created by "Khalid Olowe-Makorie, Vodafone" on 08/10/2024.
//

import UIKit

class GHAvatarImageView: UIImageView {
    
    let placeholderImage = UIImage(named: Images.placeholderImage)
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
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
