//
//  FavouriteCell.swift
//  GHFollowers
//
//  Created by "Khalid Olowe-Makorie, Vodafone" on 15/10/2024.
//

import UIKit

class FavouriteCell: UITableViewCell {

    static let reuseID = "FavouriteCell"
    
    let avatarImageView = GHAvatarImageView(frame: .zero) //can give a .zero frame cos we'll handle it all with constraints
    let usernameLabel = GHTitleLabel(textAlignment: .left, fontSize: 26)
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favourite: Follower) {
        usernameLabel.text = favourite.login
        avatarImageView.downloadAvatarImage(fromURL: favourite.avatarUrl)
    }
    
    private func configure() {
        let padding: CGFloat = 12
        addSubviews(avatarImageView, usernameLabel)
        accessoryType = .disclosureIndicator
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),//center in the cell
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
}
