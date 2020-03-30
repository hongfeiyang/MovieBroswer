//
//  BaseNavItemController.swift
//  MovieToWatch
//
//  Created by Clark on 30/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class BaseNavItemController: UIViewController {
    
    var isFirstVCInNavStack: Bool {
        return self == navigationController?.viewControllers[0]
    }
    
    func setupNavigationBar() {
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.label]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
            navBarAppearance.backgroundColor = .clear
            navBarAppearance.shadowColor = .clear
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        } else {
            navigationController?.navigationBar.backgroundColor = .clear
            navigationController?.navigationBar.shadowImage = UIImage()
        }
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.prefersLargeTitles = false
        
        navigationController?.view.backgroundColor = .clear
        
        let backImage = UIImage(systemName: "chevron.left", withConfiguration: UIImage.SymbolConfiguration(weight: .medium))?.withTintColor(.label, renderingMode: .alwaysOriginal)
        let dismissImage = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(weight: .medium))?.withTintColor(.label, renderingMode: .alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: isFirstVCInNavStack ? dismissImage : backImage, style: .plain, target: self, action: #selector(leftItemTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(rightItemTapped))
    }
    
    @objc func leftItemTapped() {
        if isFirstVCInNavStack {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func rightItemTapped() {
        print("rightItemTapped")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
}
