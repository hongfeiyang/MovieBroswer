//
//  MovieCardViewModel.swift
//  MovieToWatch
//
//  Created by Clark on 20/2/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import Foundation

struct MovieCardViewModel {
    let imageURL: URL?
    let title: String
    let overview: String
    let voteAverage: String
    
    init(content: DiscoverMovieResult) {
        self.imageURL = APIConfiguration.parsePosterURL(file_path: content.posterPath, size: .original)
        self.title = content.title ?? ""
        self.overview = content.overview ?? ""
        self.voteAverage = String(content.voteAverage ?? 0)
    }
}
