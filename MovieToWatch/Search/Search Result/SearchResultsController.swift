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
    var results: [ISearchResult]?
    var page: Int?
    var totalPages: Int?
    
    let loadingCellId = "loadingCell"
    let movieResultCellId = "movieResultCell"
    let tvResultCellId = "tvResultCell"
    let personResultCellId = "personResultCell"
    
    var pageIsLoadingMoreContent = false
    
    weak var navController: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        tableView.delaysContentTouches = false
        tableView.register(MovieSearchResultCell.self, forCellReuseIdentifier: movieResultCellId)
        tableView.register(loadingTableViewCell.self, forCellReuseIdentifier: loadingCellId)
        tableView.register(PersonSearchResultCell.self, forCellReuseIdentifier: personResultCellId)
        tableView.register(TvSearchResultCell.self, forCellReuseIdentifier: tvResultCellId)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
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
            let cell = tableView.dequeueReusableCell(withIdentifier: loadingCellId) as! loadingTableViewCell
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
                let cell = tableView.dequeueReusableCell(withIdentifier: movieResultCellId) as! MovieSearchResultCell
                cell.result = results?[indexPath.row]
                return cell
            case .tv:
                let cell = tableView.dequeueReusableCell(withIdentifier: tvResultCellId) as! TvSearchResultCell
                cell.result = results?[indexPath.row]
                return cell
            case .person:
                let cell = tableView.dequeueReusableCell(withIdentifier: personResultCellId) as! PersonSearchResultCell
                cell.result = results?[indexPath.row]
                return cell
            default:
                fatalError("not implemented: \(String(describing: results?[indexPath.row]))")
            }
            
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            tableView.deselectRow(at: indexPath, animated: false)
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
            let result = results?[indexPath.row]
            switch result?.media_type {
            case .movie:
                if let id = (result as? MovieMultiSearchResult)?.id {
                    let vc = MovieDetailViewController()
                    vc.movieId = id
                    vc.hidesBottomBarWhenPushed = true
                    navController?.pushViewController(vc, animated: true)
                }
            case .tv:
                break
            case .person:
                if let id = (result as? PersonMultiSearchResult)?.id {
                    let vc = PersonContainerController()
                    vc.personId = id
                    vc.hidesBottomBarWhenPushed = true
                    navController?.pushViewController(vc, animated: true)
                }
            default:
                fatalError("not implemented: \(String(describing: results?[indexPath.row]))")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        cell.layoutIfNeeded()
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.9, options: [.curveEaseOut, .allowUserInteraction], animations: {
            cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            cell.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        cell.layoutIfNeeded()
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.9, options: [.curveEaseOut, .allowUserInteraction], animations: {
            cell.transform = .identity
            cell.layoutIfNeeded()
        }, completion: nil)
    }

    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let triggerOffset = CGFloat(100)
        if yOffset > contentHeight - scrollView.frame.height - triggerOffset && !pageIsLoadingMoreContent {
            guard let _ = results, let _ = query, let totalPages = totalPages, let page = page, page <= totalPages else { return }
            let pageToFetch = page + 1
            
            let nextQuery = MultiSearchQuery(query: self.query!.query, language: self.query?.language, page: pageToFetch, include_adult: self.query?.include_adult, region: self.query?.region)
    
            Network.getMultiSearch(query: nextQuery) { [weak self] (res) in
                DispatchQueue.main.async {
                    switch res {
                    case .success(let multiSearchResults):
                        if self?.results == nil {
                            break
                        }
                        self?.results! += multiSearchResults.results
                        self?.tableView.reloadData()
                        
                    case .failure(let error):
                        print(error)
                    }
                    self?.pageIsLoadingMoreContent = false
                }
            }
            self.pageIsLoadingMoreContent = true
        }
    }
}
