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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
//        tableView.dataSource = self
//        tableView.delegate = self
        tableView.keyboardDismissMode = .interactive
        tableView.backgroundColor = .systemBackground
//        tableView.register(MovieSearchResultsTableViewCell.self, forCellReuseIdentifier: resultCell)
//        tableView.register(loadingTableViewCell.self, forCellReuseIdentifier: loadingCell)
        return tableView
    }()
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        searchController.delegate = self
//        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController?.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        self.title = "Search"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        loadTrending()
    }
}

extension MovieSearchViewController {
    func loadTrending() {
        let item = TrendingQuery(media_type: .all, time_window: .week)
        Network.getTrending(query: item) { (res) in
            switch res {
            case .success(let results):
                break
                //print(results)
            case .failure(let error):
                print(error)
            }
        }
    }
}


extension MovieSearchViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func didPresentSearchController(_ searchController: UISearchController) {
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
    }
}

extension MovieSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        if text == "" {
            return
        }
        let query = MultiSearchQuery(query: text)
        resultsController.query = query
        resultsController.results = nil
        resultsController.searchResults = nil
        resultsController.loadData(completion: nil)
    }
}
