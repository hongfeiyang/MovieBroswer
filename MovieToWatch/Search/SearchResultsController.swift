//
//  SearchResultsController.swift
//  MovieToWatch
//
//  Created by Clark on 10/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class SearchResultsController: UITableViewController {
    
    var query: MultiSearchQuery?
    var searchResults: MultiSearchResults?
    var results: [ISearchResult]?
    var page: Int? { return searchResults?.page }
    var totalPages: Int? { return searchResults?.total_pages }

    let loadingCell = "loadingCell"
    let movieResultCell = "movieResultCell"
    let tvResultCell = "tvResultCell"
    let personResultCell = "personResultCell"
    
    var pageIsLoadingMoreContent = false

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.keyboardDismissMode = .onDrag
        tableView.register(MovieSearchResultCell.self, forCellReuseIdentifier: movieResultCell)
        tableView.register(loadingTableViewCell.self, forCellReuseIdentifier: loadingCell)
        tableView.rowHeight = 130//UITableView.automaticDimension
        //tableView.estimatedRowHeight = 200
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let results = results {
            return results.count + 1
        } else {
            return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: loadingCell) as! loadingTableViewCell
            if let page = page, let totalPages = totalPages, page < totalPages {
                cell.activityIndicator.startAnimating()
                cell.lastPageLabel.isHidden = true
            } else {
                cell.activityIndicator.stopAnimating()
                cell.lastPageLabel.isHidden = false
            }
            return cell
        } else {
           
            switch results?[indexPath.row].media_type {
            case .movie:
                let cell = tableView.dequeueReusableCell(withIdentifier: movieResultCell) as! MovieSearchResultCell
                cell.result = results?[indexPath.row]
                return cell
            case .tv:
                let cell = tableView.dequeueReusableCell(withIdentifier: movieResultCell) as! MovieSearchResultCell
                cell.result = nil
                cell.titleLabel.text = "A TV"
                return cell
            case .person:
                let cell = tableView.dequeueReusableCell(withIdentifier: movieResultCell) as! MovieSearchResultCell
                cell.result = nil
                cell.titleLabel.text = "A Person"
                return cell
            default:
                print(results?[indexPath.row])
                fatalError("not implemented")
            }
            
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            tableView.deselectRow(at: indexPath, animated: false)
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
//            let vc = MovieDetailViewController()
//            vc.movieId = results?[indexPath.row].id
//            vc.hidesBottomBarWhenPushed = true
//            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func loadData(completion: (() -> Void)?) {
        Network.getMultiSearch(query: query!) { [weak self] (res) in
            guard let self = self else {completion?(); return}
            switch res {
            case .success(let multiSearchResults):
                self.searchResults = multiSearchResults
                if self.results != nil {
                    self.results! += multiSearchResults.results
                } else {
                    self.results = multiSearchResults.results
                }
            case .failure(let error):
                print(error)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                completion?()
            }
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let triggerOffset = CGFloat(100)
        if yOffset > contentHeight - scrollView.frame.height - triggerOffset && !pageIsLoadingMoreContent {
            guard let _ = query, let totalPages = totalPages, let page = page, page <= totalPages else { return }
            let pageToFetch = page + 1
            query!.page = pageToFetch
            loadData {
                self.pageIsLoadingMoreContent = false
            }
            self.pageIsLoadingMoreContent = true
        }
    }
}
