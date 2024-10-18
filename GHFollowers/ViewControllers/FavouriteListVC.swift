//
//  FavouriteListVC.swift
//  GitApp
//
//  Created by "Khalid Olowe-Makorie, Vodafone" on 02/10/2024.
//

import UIKit

class FavouriteListVC: GHDataLoadingVC {
    
    let tableView = UITableView()
    var favourites: [Follower] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
       // getFavourites()
        print("on load")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavourites()
        print("on appear")
    }
    
    func getFavourites() {
        PersistenceManager.retrieveFavourites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favourites):
                
                if favourites.isEmpty {
                    showEmptyStateView(with: "No Favourites?\nAdd one on the follower screen", in: self.view)
                }else{
                    self.favourites = favourites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView) //ensures table view is shown above empty state in case both active
                    }
                }
                
            case .failure(let error):
                self.presentGHAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
            
        }
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.rowHeight = 80
        tableView.register(FavouriteCell.self, forCellReuseIdentifier: FavouriteCell.reuseID)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureVC() {
        title = "Favourites"
        navigationController?.navigationBar.prefersLargeTitles = true //put large title
        view.backgroundColor = .systemBackground
    }
    
}


extension FavouriteListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites.count
    }
    
    //called everytime a cell is visible
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteCell.reuseID) as! FavouriteCell
        let favourite = favourites[indexPath.row]
        cell.set(favourite: favourite)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favourite = favourites[indexPath.row]
        let destVC = FollowerListVC(username: favourite.login)
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return } //we only care about return for this feature
        
        PersistenceManager.update(with: favourites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self = self else {return}
            guard let error = error else {
                
                self.favourites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            
            self.presentGHAlertOnMainThread(title: "This favourite could not be deleted", message: error.rawValue, buttonTitle: "Ok")
        }
        
    }
    
}
