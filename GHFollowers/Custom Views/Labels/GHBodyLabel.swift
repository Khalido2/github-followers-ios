//
//  GHBodyLabel.swift
//  GHFollowers
//
//  Created by "Khalid Olowe-Makorie, Vodafone" on 02/10/2024.
//

import UIKit

class GHBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init (textAlignment: NSTextAlignment){
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
    private func configure () {
        textColor = .secondaryLabel
        
        font = UIFont.preferredFont(forTextStyle: .body) //these 2 lines make body text conform to dynamic type
        adjustsFontForContentSizeCategory = true
        
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75 //shrink upt o 75%
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
