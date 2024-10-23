//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by "Khalid Olowe-Makorie, Vodafone" on 08/10/2024.
//

import UIKit
import SwiftUI

class FollowerCell: UICollectionViewCell {
    static let reuseID = "FollowerCell"
    
    let avatarImageView = GHAvatarImageView(frame: .zero) //can give a .zero frame cos we'll handle it all with constraints
    let usernameLabel = GHTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        if #available(iOS 16.0, *){
            contentConfiguration = UIHostingConfiguration {
                FollowerView(follower: follower)
            }
        } else {
            usernameLabel.text = follower.login
            avatarImageView.downloadAvatarImage(fromURL: follower.avatarUrl)
        }
    }
    
    private func configure() {
        let padding: CGFloat = 8
        addSubviews(avatarImageView, usernameLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
