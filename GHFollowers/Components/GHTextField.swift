//
//  GHTextField.swift
//  GHFollowers
//
//  Created by "Khalid Olowe-Makorie, Vodafone" on 02/10/2024.
//

import UIKit

class GHTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: <#T##CGRect#>)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true //adjust font to fit in the box if value is long
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        
        placeholder = "Enter a username"
    }
}
