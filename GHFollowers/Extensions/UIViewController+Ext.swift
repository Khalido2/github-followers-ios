//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by "Khalid Olowe-Makorie, Vodafone" on 02/10/2024.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentGHAlert(title: String, message: String, buttonTitle: String) {
        let alertVC = GHAlertVC(title: title, message: message, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
    
    func presentDefaultError() {
        let alertVC = GHAlertVC(title: "Something went wrong", message: "Unable to complete task, please try again", buttonTitle: "Ok")
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
    
    func presentSafariVC(with url: URL){
        let safaricVC = SFSafariViewController(url: url)
        safaricVC.preferredControlTintColor = .systemGreen
        present(safaricVC, animated: true)
    }
}
