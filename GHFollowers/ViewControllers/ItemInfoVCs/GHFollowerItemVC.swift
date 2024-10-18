//
//  GHFollowerItemVC.swift
//  GHFollowers
//
//  Created by "Khalid Olowe-Makorie, Vodafone" on 14/10/2024.
//

import UIKit

protocol FollowerItemVCDelegate: AnyObject {
    func didTapGetFollowers(user: User)
}


class GHFollowerItemVC: GHItemInfoVC {
    
    weak var delegate: FollowerItemVCDelegate!
    
    init(user: User, delegate: FollowerItemVCDelegate!) {
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
        itemInfoViewOne.set(itemInfoType: .followers, with: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, with: user.following)
        
        actionButtom.set(backgroundColour: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped(){
        delegate.didTapGetFollowers(user: user)
    }
}

