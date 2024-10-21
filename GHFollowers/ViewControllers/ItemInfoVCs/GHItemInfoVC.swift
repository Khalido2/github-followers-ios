//
//  GHItemInfoVC.swift
//  GHFollowers
//
//  Created by "Khalid Olowe-Makorie, Vodafone" on 14/10/2024.
//

import UIKit

class GHItemInfoVC: UIViewController {
    
    let stackView = UIStackView()
    let itemInfoViewOne = GHItemInfoView()
    let itemInfoViewTwo = GHItemInfoView()
    let actionButtom = GHButton()
    
    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        layoutUI()
        configureStackView()
        configureActionButton()
    }
        
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
       
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }
    
    private func configureActionButton() {
        actionButtom.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    @objc func actionButtonTapped() {
        // no implementation
    }
    
    private func layoutUI(){
        let padding:CGFloat = 20
        
        view.addSubviews(stackView, actionButtom)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding*1.2),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButtom.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding*1.2),
            actionButtom.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButtom.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButtom.heightAnchor.constraint(equalToConstant: 54),
        ])
    }
}
