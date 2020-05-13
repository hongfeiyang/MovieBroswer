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
    
    
    lazy var savedMoviesTableView: UITableView = {
        let view = UITableView()
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(savedMoviesTableView)
        savedMoviesTableView.fillSuperview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movies = CoreDataManager.shared.fetchRecordForEntity("Movie") as! [MovieMO]
    }
}


extension SavedMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let movie = movies[indexPath.row]
        cell.textLabel?.text = movie.value(forKey: "title") as? String
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
