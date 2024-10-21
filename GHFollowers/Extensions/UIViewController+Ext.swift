//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by "Khalid Olowe-Makorie, Vodafone" on 02/10/2024.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentGHAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GHAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func presentSafariVC(with url: URL){
        let safaricVC = SFSafariViewController(url: url)
        safaricVC.preferredControlTintColor = .systemGreen
        present(safaricVC, animated: true)
    }
}
