//
//  TabbarViewController.swift
//  MovieToWatch
//
//  Created by Clark on 25/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    
    let vc1 = TestViewController()
    let vc2 = MovieSearchViewController()
    let vc3 = BrowseMovieViewController()
    let vc4 = SavedMoviesViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        let discoverImage = UIImage.symbolWithTintColor(symbol: "lightbulb", weight: .regular, tintColor: .systemGray)
        let discoverHighlightedImage = UIImage.symbolWithTintColor(symbol: "lightbulb.fill", weight: .regular, tintColor: .systemBlue)
        vc1.tabBarItem = UITabBarItem(title: "Discover", image: discoverImage, selectedImage: discoverHighlightedImage)
        
        let searchImage = UIImage.symbolWithTintColor(symbol: "magnifyingglass.circle", weight: .regular, tintColor: .systemGray)
        let searchHighlightedImage = UIImage.symbolWithTintColor(symbol: "magnifyingglass.circle.fill", weight: .regular, tintColor: .systemBlue)
        vc2.tabBarItem = UITabBarItem(title: "Search", image: searchImage, selectedImage: searchHighlightedImage)
        
        let browseImage = UIImage.symbolWithTintColor(symbol: "film", weight: .regular, tintColor: .systemGray)
        let browseHighlightedImage = UIImage.symbolWithTintColor(symbol: "film.fill", weight: .regular, tintColor: .systemBlue)
        vc3.tabBarItem = UITabBarItem(title: "Browse", image: browseImage, selectedImage: browseHighlightedImage)
        
        let myList = UIImage.symbolWithTintColor(symbol: "square.and.arrow.down", weight: .regular, tintColor: .systemGray)
        let myListHighlightedImage = UIImage.symbolWithTintColor(symbol: "square.and.arrow.down.fill", weight: .regular, tintColor: .systemBlue)
        vc4.tabBarItem = UITabBarItem(title: "My list", image: myList, selectedImage: myListHighlightedImage)
        let vcs = [vc1, vc2, vc3, vc4]
        
        viewControllers = vcs.map { UINavigationController(rootViewController: $0)}
        selectedIndex = 0
    }
}
