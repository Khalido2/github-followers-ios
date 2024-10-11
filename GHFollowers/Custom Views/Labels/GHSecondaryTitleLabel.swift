//
//  GHSecondaryTitleLabel.swift
//  GHFollowers
//
//  Created by "Khalid Olowe-Makorie, Vodafone" on 11/10/2024.
//

import UIKit

class GHSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init (fontSize: CGFloat){
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }
    
    private func configure () {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9 //shrink upt o 90%
        lineBreakMode = .byTruncatingTail //breaks off ending with ...
        translatesAutoresizingMaskIntoConstraints = false
    }
}

