//
//  DateParser.swift
//  MovieToWatch
//
//  Created by Clark on 10/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import Foundation

class DateParser {
    
    static var shared = DateParser()
    
    func parseDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)
        return date
    }
}
