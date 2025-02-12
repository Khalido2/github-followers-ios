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
    
    convenience init(backgroundColour: UIColor, title: String, systemImageName: String){
        self.init(frame: .zero)
        set(backgroundColour: backgroundColour, title: title, systemImageName: systemImageName)
    }
    
    private func configure() {
        configuration = .filled()
        configuration?.cornerStyle = .medium

        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false //use auto layout
    }
    
    final func set(backgroundColour: UIColor, title: String, systemImageName: String){
        
        configuration?.baseBackgroundColor = backgroundColour
        configuration?.baseForegroundColor = .white
        configuration?.title = title
        
        configuration?.image = UIImage(systemName: systemImageName)
        configuration?.imagePadding = 6
        configuration?.imagePlacement = .leading
    }
}

#Preview {
    return GHButton(backgroundColour: .blue, title: "Test Button", systemImageName: "pencil")
}
