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
    let vc3 = MainMovieViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        vc1.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        vc2.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        vc3.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 3)
        let vcs = [vc1, vc2, vc3]
        
        viewControllers = vcs.map { UINavigationController(rootViewController: $0)}
        // Do any additional setup after loading the view.
    }
}
