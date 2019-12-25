////
////  ViewController.swift
////  MovieToWatch
////
////  Created by Clark on 16/12/19.
////  Copyright © 2019 Hongfei Yang. All rights reserved.
////
//
//import UIKit
//import CoreData
//
//class MainViewController: UIViewController {
//
//
//    private var cardPresentAnimator = CardPresentAnimator()
//    private var cardDismissAnimator = CardDismissAnimator()
//    private var currentPage = 0
//    private var pageIsLoadingMoreContent = false
//
//    private lazy var tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.backgroundColor = .systemBackground
//        tableView.refreshControl = refreshControl
//
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(CardTableViewCell.self, forCellReuseIdentifier: "Cell")
//        return tableView
//    }()
//
//    private lazy var refreshControl: UIRefreshControl = {
//        let control = UIRefreshControl()
//        control.addTarget(self, action: #selector(refresh), for: .valueChanged)
//        return control
//    }()
//
//    @objc private func refresh() {
//
//        currentPage = 1
//        loadMoreData() {
//            //DispatchQueue.main.async {
//                self.refreshControl.endRefreshing()
//            //}
//        }
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//
//        print("Low memory warning")
//    }
//
//    private func setupLayout() {
//
//        let constraints = [
//            tableView.topAnchor.constraint(equalTo: view.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ]
//
//        NSLayoutConstraint.activate(constraints)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.addSubview(tableView)
//        setupLayout()
//        refresh()
//
//        do {
//            try fetchedResultsController.performFetch()
//        } catch let error {
//            print(error.localizedDescription)
//        }
//
//
//
//    }
//
//    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<MovieMO> = {
//        let fetchRequest: NSFetchRequest<MovieMO> = MovieMO.fetchRequest()
//
//        let sortDescriptor = NSSortDescriptor(key: "popularity", ascending: false)
//
//        fetchRequest.sortDescriptors = [sortDescriptor]
//
//        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.shared.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
//
//        controller.delegate = self
//        return controller
//    }()
//}
//
//
//extension MainViewController: NSFetchedResultsControllerDelegate {
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.beginUpdates()
//    }
//
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
//        switch type {
//        case .insert:
//            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
//        case .delete:
//            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
//        case .move:
//            break
//        case .update:
//            break
//        @unknown default:
//            fatalError("unimplemented case")
//        }
//    }
//
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//
//        switch type {
//        case .insert:
//            tableView.insertRows(at: [newIndexPath!], with: .fade)
//        case .delete:
//            tableView.deleteRows(at: [indexPath!], with: .fade)
//        case .update:
//            tableView.reloadRows(at: [indexPath!], with: .fade)
//        case .move:
//            tableView.moveRow(at: indexPath!, to: newIndexPath!)
//        @unknown default:
//            fatalError("unimplemented case")
//        }
//
//    }
//
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//
//        tableView.endUpdates()
//
//        //pageIsLoadingMoreContent = false
//    }
//}
//
//extension MainViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let results = fetchedResultsController.fetchedObjects else {return 0}
//
//        return results.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CardTableViewCell
//        configureCell(cell, at: indexPath)
//        return cell
//    }
////
////    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
////
////        configureCell(cell as! CardTableViewCell, at: indexPath)
////    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return (UIScreen.main.bounds.width - 20 * 2) * 6/5
//    }
//
//
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = DetailMovieViewController()
//        let result = fetchedResultsController.object(at: indexPath)
//        vc.content = result
//        vc.modalPresentationStyle = .custom
//        vc.transitioningDelegate = self
//        //vc.isModalInPresentation = true
//        present(vc, animated: true, completion: nil)
//    }
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        let yOffset = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//        let triggerOffset = CGFloat(100)
//
//        if yOffset > contentHeight - scrollView.frame.height + triggerOffset && !pageIsLoadingMoreContent {
//            currentPage += 1
//            loadMoreData() {
//                self.pageIsLoadingMoreContent = false
//            }
//            self.pageIsLoadingMoreContent = true
//
//        }
//    }
//
//}
//
//
//
//extension MainViewController: UIViewControllerTransitioningDelegate {
//
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//
//        guard
//            let selectedIndexPathCell = tableView.indexPathForSelectedRow,
//            let selectedCell = tableView.cellForRow(at: selectedIndexPathCell) as? CardTableViewCell,
//            let selectedCellSuperview = selectedCell.superview
//            else {
//                return nil
//        }
//
//        cardPresentAnimator.cell = selectedCell
//        cardPresentAnimator.originFrame = selectedCellSuperview.convert(selectedCell.frame, to: nil)
//
//        return cardPresentAnimator
//    }
//
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//
//        guard
//            let selectedIndexPathCell = tableView.indexPathForSelectedRow,
//            let selectedCell = tableView.cellForRow(at: selectedIndexPathCell) as? CardTableViewCell,
//            let selectedCellSuperview = selectedCell.superview
//            else {
//                return nil
//        }
//        cardDismissAnimator.cell = selectedCell
//        cardDismissAnimator.originFrame = selectedCellSuperview.convert(selectedCell.frame, to: nil)
//
//        return cardDismissAnimator
//    }
//
//}
//
//
//extension MainViewController {
//
//    private func loadMoreData(completion: (() -> Void)? = nil) {
//        let discoverMovieQuery = DiscoverMovieQuery(language: nil, region: "AU", sort_option: nil, order: nil, page: currentPage, include_adult: true, include_video: true)
//        Network.getDiscoverMovieResults(query: discoverMovieQuery) {
//            completion?()
//        }
//    }
//
//    private func configureCell(_ cell: CardTableViewCell, at indexPath: IndexPath) {
////        guard let cell = cell as? CardTableViewCell else {fatalError("no cell named CardCollectionViewCell")}
//
//        let result = fetchedResultsController.object(at: indexPath)
//        cell.content = result
//
////        if let posterPath = result.posterPath {
////            guard let imageURL = APIConfiguration.parsePosterURL(file_path: posterPath, size: .original) else {return}
////            CoreDataManager.shared.readImage(url: imageURL.absoluteString) { (url, image) in
////                if url == imageURL.absoluteString {
////                    cell.posterImage = image
////                }
////            }
////        }
//
//
//    }
//
//}
