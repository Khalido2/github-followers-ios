//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by "Khalid Olowe-Makorie, Vodafone" on 18/10/2024.
//

import UIKit

extension UIView {
    
    //uses variadic parameter, takes in any number of instances of that type, marked by ...
    //automatically turns it into an array
    func addSubviews(_ views: UIView...){
        for view in views {
            addSubview(view)
        }
    }
}
