//
//  SearchViewController.swift
//  MovieToWatch
//
//  Created by Clark on 25/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController {

    var searchQuery = MovieSearchQuery(query: "")
    var results = [MovieSearchResult]()
    
    private lazy var searchController = UISearchController(searchResultsController: nil)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .interactive
        tableView.backgroundColor = .systemBackground
        tableView.register(MovieSearchResultsTableViewCell.self, forCellReuseIdentifier: "searchTableViewCell")
        return tableView
    }()
    
    private func setupLayout() {
        
        view.addSubview(tableView)

        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        searchController.delegate = self
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController?.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        
        self.title = "Search"

        
        setupLayout()
    }
}


extension MovieSearchViewController: UISearchControllerDelegate {
    
    func didPresentSearchController(_ searchController: UISearchController) {
        print("Did present")
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        print("Did dismiss")
    }
    func willDismissSearchController(_ searchController: UISearchController) {
        
    }
    func willPresentSearchController(_ searchController: UISearchController) {
        
    }
    
}

extension MovieSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        searchQuery.query = text
        Network.getMovieSearchResults(query: searchQuery) { [weak self] searchResults in
            // Change datasource and reload should occur in the same call block to sync table rows numbers
            // May still have problems here
            DispatchQueue.main.async {
                self?.results = searchResults.results
                self?.tableView.reloadData()
            }
        }
    }
}


extension MovieSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell") as! MovieSearchResultsTableViewCell
        
        // Potential list out of index error here, but i dont know why
        let thisResult = results[indexPath.row]
        cell.content = thisResult
        //cell.textLabel?.text = thisResult.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}

