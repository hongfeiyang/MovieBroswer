//
//  AllCrewViewController.swift
//  MovieToWatch
//
//  Created by Clark on 30/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import UIKit

class AllCrewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        setupLayout()
    }
    
    var data : Credits! {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var cast: [Cast] {
        return data.cast
    }
    
    var crew: [Crew] {
        return data.crew
    }
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.rowHeight = 130
        view.register(CrewCell.self, forCellReuseIdentifier: "CrewCell")
        return view
    }()
    
    private func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension AllCrewViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return cast.count
        case 1:
            return crew.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CrewCell", for: indexPath) as! CrewCell
        cell.profileImageView.image = nil
        switch indexPath.section {
        case 0:
            cell.imageURL = APIConfiguration.parsePosterURL(file_path: cast[indexPath.row].profilePath, size: .w154)
            cell.nameLabel.text = cast[indexPath.row].name
            cell.jobLabel.text = cast[indexPath.row].character
        case 1:
            cell.imageURL = APIConfiguration.parsePosterURL(file_path: crew[indexPath.row].profilePath, size: .w154)
            cell.nameLabel.text = crew[indexPath.row].name
            cell.jobLabel.text = crew[indexPath.row].job
        default:
            fatalError("un-identified section")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Cast"
        case 1:
            return "Crew"
        default:
            return ""
        }
    }
}

class CrewCell: UITableViewCell {
    
    var profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    var imageURL: URL? {
        didSet {
            fetchAndSetImage()
        }
    }
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    var jobLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    private func setupLayout() {
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        jobLabel.translatesAutoresizingMaskIntoConstraints = false
        let padding = CGFloat(5)
        
        let constraints = [
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor, multiplier: 2/3),
 
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: padding),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            jobLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: padding),
            jobLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20),
            jobLabel.heightAnchor.constraint(equalToConstant: 20),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(jobLabel)
        setupLayout()
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchAndSetImage() {
//        DispatchQueue.main.async {
//            self.profileImageView.image = nil
//        }
        guard let url = imageURL else {print("failed to have a valid image url"); return}
        Cache.shared.cacheImage(url: url) { (url, image) in
            if url == self.imageURL {
                DispatchQueue.main.async {
                    self.profileImageView.image = image
                }
            }
        }
    }
}
