//
//  MovieReviewView.swift
//  MovieToWatch
//
//  Created by Clark on 3/1/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class MovieReviewView: UIView {

    var allReviewsButton = BaseButton(topic: "Reviews", content: "view all")
    
    lazy var firstReviewButton: UIButton = {
        let button =  UIButton()
        button.contentEdgeInsets = .init(top: 0, left: 5, bottom: 0, right: 5)
        button.setTitle("", for: .normal)
        button.titleLabel?.numberOfLines = 4
        //button.titleLabel?.lineBreakMode = .byTruncatingTail
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .thin)
        return button
    }()
    
    var data = MovieReviews(page: 0, results: [], totalPages: 0, totalResults: 0) {
        didSet {
            guard data.results.count > 0 else {return}
            DispatchQueue.main.async {
                let review = self.data.results[0].content
                self.firstReviewButton.setTitle(review, for: .normal)
            }
        }
    }
    
    private func setupLayout() {
        let padding = CGFloat(5)
        allReviewsButton.translatesAutoresizingMaskIntoConstraints = false
        firstReviewButton.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            allReviewsButton.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            allReviewsButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            allReviewsButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            allReviewsButton.heightAnchor.constraint(equalToConstant: 40),
            
            firstReviewButton.topAnchor.constraint(equalTo: allReviewsButton.bottomAnchor, constant: padding),
            firstReviewButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            firstReviewButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            firstReviewButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            firstReviewButton.heightAnchor.constraint(equalToConstant: 80)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(allReviewsButton)
        addSubview(firstReviewButton)
        
        backgroundColor = .secondarySystemBackground
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class AllReviewsController: UIViewController {

    var page = 0
    var totalPages = 0
    var totalResults = 0
    var dataSource = [ReviewsResult]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(ReviewCell.self, forCellReuseIdentifier: "ReviewCell")
        view.rowHeight = UITableView.automaticDimension
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        setupLayout()
    }
    
    private func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension AllReviewsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell") as! ReviewCell
        
        if let author = dataSource[indexPath.row].author {
            cell.authorLabel.text = "By: \(author)"
        } else {
            cell.authorLabel.text = "Unknown Author"
        }
        
        cell.reviewDetail.text = dataSource[indexPath.row].content
        
        return cell
    }
}


class ReviewCell: UITableViewCell {
    
    var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    var reviewDetail: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .thin)
        label.textColor = .label
        return label
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
    
    private func setupLayout() {
        reviewDetail.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let padding = CGFloat(5)
        
        let constraints = [
            
            authorLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            //authorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            reviewDetail.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: padding),
            reviewDetail.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            reviewDetail.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            reviewDetail.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(reviewDetail)
        addSubview(authorLabel)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
