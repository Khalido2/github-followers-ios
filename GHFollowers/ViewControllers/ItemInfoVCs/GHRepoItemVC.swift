//
//  GHRepoItemVC.swift
//  GHFollowers
//
//  Created by "Khalid Olowe-Makorie, Vodafone" on 14/10/2024.
//

import UIKit

protocol RepoItemVCDelegate: AnyObject {
    func didTapGitHubProfile(user: User)
}

class GHRepoItemVC: GHItemInfoVC {
    
    weak var delegate: RepoItemVCDelegate!
    
    init(user: User, delegate: RepoItemVCDelegate!) {
        super.init(user: user)
        self.delegate = delegate
        self.user = user
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems(){
        itemInfoViewOne.set(itemInfoType: .repos, with: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, with: user.publicGists)
        
        actionButtom.set(backgroundColour: .systemPurple, title: "GitHub Profile", systemImageName: "person")
    }
    
    override func actionButtonTapped(){
        delegate.didTapGitHubProfile(user: user)
    }
}
