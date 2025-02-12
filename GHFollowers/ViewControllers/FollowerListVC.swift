//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by "Khalid Olowe-Makorie, Vodafone" on 02/10/2024.
//

import UIKit

class FollowerListVC: GHDataLoadingVC {
    
    enum Section {
        case main
    }
    
    var username: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var currentPage = 1
    
    var hasMoreFollowers = true
    var isSearching = false
    var isLoadingMoreFollowers = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    init (username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        self.title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        getFollowers(username: username, page: currentPage)
        configureDataSource()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        if followers.isEmpty && !isLoadingMoreFollowers {
            var config = UIContentUnavailableConfiguration.empty()
            config.image = .init(systemName: "person.slash")
            config.text = "No Followers"
            config.secondaryText = "This user has no followers."
            contentUnavailableConfiguration = config
        } else if isSearching && filteredFollowers.isEmpty{
            contentUnavailableConfiguration = UIContentUnavailableConfiguration.search()
        }else {
            contentUnavailableConfiguration = nil
        }
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a user"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

    }
    
    func getFollowers(username: String, page: Int){
        showLoadingView()
        isLoadingMoreFollowers = true
        
        Task {
            do {
                let followers = try await NetworkManager.shared.getFollowers(for: username, page: currentPage)
                self.updateUI(with: followers)
                
            } catch {
                if let ghError = error as? GHError {
                    presentGHAlert(title: "Error", message: ghError.rawValue, buttonTitle: "Ok")
                }else {
                    presentDefaultError()
                }
            }

            dismissLoadingView()
            isLoadingMoreFollowers = false
        }
    }
    
    func updateUI(with followers: [Follower]){
        if followers.count < NetworkManager.itemsPerPage { self.hasMoreFollowers = false }
        self.followers.append(contentsOf: followers)
        
        //Old custom empty state
        /*
        if(self.followers.isEmpty){
            let message = "This user does not have any followers."
            DispatchQueue.main.async {
                self.showEmptyStateView(with: message, in: self.view)
            }
            return
        }*/
        
        self.updateData(on: self.followers)
        setNeedsUpdateContentUnavailableConfiguration()
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        collectionView.delegate = self
        
        let favButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(FavouritesButtonTapped))
        navigationItem.rightBarButtonItem = favButton
    }
    
    //This function effectively configures the datasource to know what type the cells will be and how it will intialise and configure them
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        //on main thread
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
    
    @objc func FavouritesButtonTapped() {
        showLoadingView()
        
        Task {
            do {
                let user = try await NetworkManager.shared.getUserInfo(for: username)
                addUserToFavourites(user: user)
            } catch {
                if let ghError = error as? GHError {
                    presentGHAlert(title: "Something went wrong", message: ghError.rawValue, buttonTitle: "Ok")
                }else {
                    presentDefaultError()
                }
            }
            
            self.dismissLoadingView()
        }
    }
    
    func addUserToFavourites(user: User){
        let favourite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        

        
        PersistenceManager.update(with: favourite, actionType: .add) { [weak self] error in
            guard let self else { return }
            guard let error else { //when error is nil aka succesful operation
                DispatchQueue.main.async {
                    self.presentGHAlert(title: "Success!", message: "User succesfully favourited.", buttonTitle: "Yay")
                }
                return
            }
            
            DispatchQueue.main.async {
                self.presentGHAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height //entire scrollview
        let height = scrollView.frame.size.height //size of visible frame
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
            currentPage += 1
            getFollowers(username: username, page: currentPage)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]

        let userInfoVC = UserInfoVC()
        userInfoVC.username = follower.login
        userInfoVC.delegate = self
        
        let navController = UINavigationController(rootViewController: userInfoVC)
        present(navController  , animated: true)
        
    }
}

extension FollowerListVC: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            isSearching = false
            filteredFollowers.removeAll()
            updateData(on: followers)
            setNeedsUpdateContentUnavailableConfiguration()
            return
        }
        
        isSearching = true
        
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) } //this is effectively a map reduce function but in a closure aka lambda
        //$0 is the item in the map reduce aka follower, we grab the login, lowercase it and check if it contains the filter text also lowercased
        updateData(on: filteredFollowers)
        setNeedsUpdateContentUnavailableConfiguration()
    }
    
}

extension FollowerListVC: UserInfoVCDelegate {
    
    func didRequestFollowers(for username: String) {
        self.username = username //reset the page
        title = username
        
        followers.removeAll()
        filteredFollowers.removeAll()
        currentPage = 1
        
        collectionView.scrollToItem(at: IndexPath(index: 0), at: .top, animated: true) //scroll collection view to the top item
        
        getFollowers(username: username, page: currentPage)
    }
}

