//
//  SearchVC.swift
//  GitApp
//
//  Created by "Khalid Olowe-Makorie, Vodafone" on 02/10/2024.
//

import UIKit

class SearchVC: UIViewController {

    let logoImageView = UIImageView()
    let usernameTextField = GHTextField()
    let callToAction = GHButton(backgroundColour: .systemGreen, title: "Get Followers")
    
    var logoImageViewTopConstraint: NSLayoutConstraint!
    
    var isUsernameEntered: Bool {
        return !usernameTextField.text!.isEmpty
    }
    
    
    //Runs each time VC is loaded (just the once)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDissmissKeyboardTapGesture()
    }
    
    //Runs each time VC appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //@objc exposes it to objective C
    @objc func pushFollowerListVC() {
        
        guard isUsernameEntered else {
            presentGHAlertOnMainThread(title: "Empty Username", message: "Please enter a username.", buttonTitle: "Ok")
            return }
    
        
        let followerListVC = FollowerListVC(username: usernameTextField.text!)
        
        usernameTextField.resignFirstResponder()
        usernameTextField.text = ""
        
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    func createDissmissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing ))
        view.addGestureRecognizer(tap)
    }
   
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: Images.logo)
        
        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE ? 20 : 80
        
        if DeviceTypes.isiPhoneSE {
            print("Ihpone SE")
        }
        
        print("\(UIDevice.current.model)")
        
        logoImageViewTopConstraint = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant)
        
        logoImageViewTopConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCallToActionButton() {
        view.addSubview(callToAction)
        callToAction.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToAction.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToAction.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToAction.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToAction.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension  SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
