//
//  SearchViewController.swift
//  MovieToWatch
//
//  Created by Clark on 25/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController {

    var searchQuery = MovieSearchQuery(query: "", language: nil, page: nil, include_adult: nil, region: nil, year: nil, primary_release_year: nil)
    var totalResultPages: Int?
    var results: [MovieSearchResult]?
    
    let resultCell = "resultCell"
    let loadingCell = "loadingCell"
    
    var pageIsLoadingMoreContent = false
    var currentPage = 0
    
    var searchController = UISearchController(searchResultsController: nil)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .interactive
        tableView.backgroundColor = .systemBackground
        tableView.register(MovieSearchResultsTableViewCell.self, forCellReuseIdentifier: resultCell)
        tableView.register(loadingTableViewCell.self, forCellReuseIdentifier: loadingCell)
        return tableView
    }()
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        searchController.delegate = self
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
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
    }
}


extension MovieSearchViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func didPresentSearchController(_ searchController: UISearchController) {
        
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        
    }
    func willDismissSearchController(_ searchController: UISearchController) {
        clear()
    }
    func willPresentSearchController(_ searchController: UISearchController) {
        
    }
}

extension MovieSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        if text == "" {
            clear()
            return
        }
        searchQuery.query = text
        currentPage = 1
        searchQuery.page = currentPage
        
        loadMoreData() { [weak self] searchResults in
            DispatchQueue.main.async {
                // Change datasource and reload should occur in the same call block to sync table rows numbers
                self?.results = searchResults?.results
                self?.totalResultPages = searchResults?.totalPages
                self?.tableView.reloadData()
            }
        }
        
        let item = MultiSearchQuery(query: text)
        
        Network.getMultiSearch(query: item) { (results) in
            print(results.debugDescription)
        }
    }
    
    private func clear() {
        DispatchQueue.main.async {
            self.searchQuery.query = ""
            self.searchQuery.page = nil
            self.results = nil
            self.tableView.reloadData()
        }
    }
    
    func loadMoreData(completion: ((MovieSearchResults?)->Void)? = nil) {
        
        Network.getMovieSearchResults(query: searchQuery) { searchResults in
            completion?(searchResults)
        }
    }
}


extension MovieSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let results = results {
            return results.count + 1
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: loadingCell) as! loadingTableViewCell
            if let total = totalResultPages, currentPage < total {
                cell.activityIndicator.startAnimating()
                cell.lastPageLabel.isHidden = true
            } else {
                cell.activityIndicator.stopAnimating()
                cell.lastPageLabel.isHidden = false
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: resultCell) as! MovieSearchResultsTableViewCell
            let thisResult = results?[indexPath.row]
            cell.content = thisResult
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            tableView.deselectRow(at: indexPath, animated: false)
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
            let vc = MovieDetailViewController()
            vc.movieId = results?[indexPath.row].id
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            return 100
        } else {
            return 100
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
       searchController.searchBar.resignFirstResponder()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let triggerOffset = CGFloat(100)
        if yOffset > contentHeight - scrollView.frame.height - triggerOffset && !pageIsLoadingMoreContent {
            // do not initiate search when current page reaches the end total pages (response would be [] anyway, this is to save due to max number of requests limit)
            if let total = totalResultPages, total <= currentPage {
                return
            }
            currentPage += 1
            searchQuery.page = currentPage
            loadMoreData() { [weak self] searchResults in
                guard let self = self else {return}
                DispatchQueue.main.async {
                    guard let results = searchResults?.results else {self.pageIsLoadingMoreContent = false; return}
                    // Change datasource and reload should occur in the same call block to sync table rows numbers
                    
                    if self.results != nil {
                        self.results! += results
                    } else {
                        self.results = results
                    }
                    
                    self.tableView.reloadData()
                    self.pageIsLoadingMoreContent = false
                }
            }
            self.pageIsLoadingMoreContent = true
        }
    }
    
}

