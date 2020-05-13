//
//  PersonCreditHeader.swift
//  MovieToWatch
//
//  Created by Clark on 9/5/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class PersonCreditHeader: UICollectionReusableView {
    
    var title = UILabel(text: "", font: .systemFont(ofSize: 18, weight: .semibold))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(title)
        title.fillSuperview(padding: .init(top: 0, left: 20, bottom: 0, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
