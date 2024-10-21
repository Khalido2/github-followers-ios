//
//  GHEmptyStateView.swift
//  GHFollowers
//
//  Created by "Khalid Olowe-Makorie, Vodafone" on 09/10/2024.
//

import UIKit

class GHEmptyStateView: UIView {
    
    let messageLabel = GHTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String){
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    private func configure() {
        configureMessageLabel()
        configureLogoImageView()
    }
     
    private func configureLogoImageView(){
        addSubview(logoImageView)
        
        logoImageView.image = UIImage(named: Images.emptyStateLogo)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let logoBottomConstant: CGFloat = DeviceTypes.isiPhoneSE ? 80: 140
        
        let logoImageViewBottomConstaint = logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoBottomConstant)
        logoImageViewBottomConstaint.isActive = true
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 180),
        ])
    }
    
    private func configureMessageLabel(){
        addSubview(messageLabel)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE ? -90: -150
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
}
