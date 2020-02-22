//
//  MovieDetailSecionCell.swift
//  MovieToWatch
//
//  Created by Clark on 20/2/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailSectionBaseCell: UICollectionViewCell {
    
    var movieDetail: MovieDetail?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemGroupedBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
