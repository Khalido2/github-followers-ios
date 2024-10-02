//
//  GAButton.swift
//  GitApp
//
//  Created by "Khalid Olowe-Makorie, Vodafone" on 02/10/2024.
//

import UIKit

class GHButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        //Initialiser used by storyboard
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColour: UIColor, title: String){
        super.init(frame: .zero)
        self.backgroundColor = backgroundColour
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false //use auto layout
    }
}
