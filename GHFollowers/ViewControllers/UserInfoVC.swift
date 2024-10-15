//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by "Khalid Olowe-Makorie, Vodafone" on 09/10/2024.
//

import UIKit
import WebKit

protocol UserInfoVCDelegate: AnyObject {
    func didTapGitHubProfile(user: User)
    func didTapGetFollowers(user: User)
}

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var itemViews: [UIView] = []
    let dateLabel = GHBodyLabel(textAlignment: .center)
    
    var username: String!
    weak var delegate: FollowerListVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        layoutUI()
        getUserInfo()
    }
    
    func getUserInfo(){
        NetworkManager.shared.getUserInfo(for: username) {[weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let user):
                    DispatchQueue.main.async { self.configureUIElements(with: user)}
                    
                case .failure(let error):
                    self.presentGHAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = closeButton
    }
    
    func configureUIElements(with user:User){
        
        let repoItemVC = GHRepoItemVC(user: user)
        repoItemVC.delegate = self
        
        let followerItemVC = GHFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: GHUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.dateLabel.text = "On GitHub since \(user.createdAt.convertToDisplayFormat())"
    }
    
    func layoutUI(){
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 180
        
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ])
        }

        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
            
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }

}

extension UserInfoVC: UserInfoVCDelegate, WKUIDelegate {
    
    func didTapGitHubProfile(user: User) {
        
        guard let url = URL(string: user.htmlUrl) else {
            presentGHAlertOnMainThread(title: "Invalid URL", message: "URL attached to this user is invalid.", buttonTitle: "Ok")
            return
        }
        
        //Using Safari view controller
        presentSafariVC(with: url)
        
        /*
         //Using Web kit webview
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: view.bounds, configuration: webConfiguration)
        
        webView.uiDelegate = self
        
        let request = URLRequest(url: url)
        webView.load(request)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)*/
    }
    
    func didTapGetFollowers(user: User) {
        
        guard user.followers > 0 else {
            presentGHAlertOnMainThread(title: "No Followers", message: "This user has no followers ☹️.", buttonTitle: "Ah man..")
            return
        }
        
        //dismiss vc and tell follower list screen to show new user
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
}
