//
//  VideosCell.swift
//  MovieToWatch
//
//  Created by Clark on 21/2/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit
import WebKit

class VideosCell: UICollectionViewCell {

    var video: VideosResult? {
        didSet {
            switch video?.site {
            case "YouTube":
                guard let videoKey = video?.key else {return}
                let url = URL(string: "https://www.youtube.com/embed/\(videoKey)")!
                let request = URLRequest(url: url)
                videoView.stopLoading()
                videoView.load(request)
            default:
                return
            }
        }
    }
    
    var videoView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let view = WKWebView(frame: .zero, configuration: configuration)
        view.scrollView.isScrollEnabled = false
        view.clipsToBounds = true
        return view
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .tertiarySystemGroupedBackground
        addSubview(videoView)
        videoView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
