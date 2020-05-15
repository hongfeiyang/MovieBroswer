//
//  SearchViewController.swift
//  MovieToWatch
//
//  Created by Clark on 25/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController {

    var resultsController = SearchResultsController()
    
    lazy var searchController = UISearchController(searchResultsController: resultsController)

    lazy var trendingController = TrendingController()
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        searchController.delegate = self
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController?.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        self.title = "Search"
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        resultsController.navController = self.navigationController
        
        view.addSubview(trendingController.view)
        addChild(trendingController)
        trendingController.didMove(toParent: self)
        trendingController.view.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
//        navigationController?.navigationBar.isHidden = false
//        view.backgroundColor = .systemBackground
    }
}


extension MovieSearchViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    func didPresentSearchController(_ searchController: UISearchController) {
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        
        let query = MultiSearchQuery(query: text)
        Network.getMultiSearch(query: query) { [weak self] (res) in
            switch res {
            case .success(let multiSearchResults):
                DispatchQueue.main.async {
                    self?.resultsController.query = query
                    self?.resultsController.results = multiSearchResults.results
                    self?.resultsController.page = multiSearchResults.page
                    self?.resultsController.totalPages = multiSearchResults.total_pages
                    self?.resultsController.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

