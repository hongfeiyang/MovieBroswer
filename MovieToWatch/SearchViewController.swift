//
//  SearchViewController.swift
//  MovieToWatch
//
//  Created by Clark on 25/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    private var searchController = UISearchController(searchResultsController: nil)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "searchTableViewCell")
        return tableView
    }()
    
    private var data = [1,2,3,4,5,6,7,8]
    
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
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = true
        navigationItem.searchController?.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        
        self.title = "Search"

        
        setupLayout()
    }
}


extension SearchViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
    }
    
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell")!
        cell.textLabel?.text = String(data[indexPath.row])
        
        return cell
    }
    
    
}
