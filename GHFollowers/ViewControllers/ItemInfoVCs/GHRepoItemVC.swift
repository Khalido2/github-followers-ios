//
//  GHRepoItemVC.swift
//  GHFollowers
//
//  Created by "Khalid Olowe-Makorie, Vodafone" on 14/10/2024.
//

import UIKit

class GHRepoItemVC: GHItemInfoVC {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems(){
        itemInfoViewOne.set(itemInfoType: .repos, with: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, with: user.publicGists)
        
        actionButtom.set(backgroundColour: .systemPurple, title: "GitHub Profile")
    }
    
    override func actionButtonTapped(){
        delegate.didTapGitHubProfile(user: user)
    }
}
