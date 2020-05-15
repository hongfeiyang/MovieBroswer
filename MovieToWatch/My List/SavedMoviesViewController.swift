//
//  SavedMoviesViewController.swift
//  MovieToWatch
//
//  Created by Clark on 13/5/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit
import CoreData

class SavedMoviesViewController: UIViewController {
    
    var movies = [MovieMO]() {
        didSet {
            DispatchQueue.main.async {
                self.savedMoviesTableView.reloadData()
            }
        }
    }
    
    private let savedMovieCellId = "savedMovieCellId"
    
    lazy var savedMoviesTableView: UITableView = {
        let view = UITableView()
        view.register(SavedMovieCell.self, forCellReuseIdentifier: savedMovieCellId)
        //view.rowHeight = 90
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "My List"
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(savedMoviesTableView)
        savedMoviesTableView.fillSuperview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        movies = CoreDataManager.shared.fetchRecordForEntity("Movie") as! [MovieMO]
    }
}


extension SavedMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: savedMovieCellId, for: indexPath) as! SavedMovieCell
        let movie = movies[indexPath.row]
        cell.movie = movie
        //cell.textLabel?.text = movie.value(forKey: "title") as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = movies[indexPath.row]
        let vc = MovieDetailViewController()
        vc.movieId = Int(movie.id)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let movie = movies[indexPath.row]
            CoreDataManager.shared.deleteMovie(id: Int(movie.id))
            movies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
