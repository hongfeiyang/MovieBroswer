//
//  PersonCreditViewModel.swift
//  MovieToWatch
//
//  Created by Clark on 19/4/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import Foundation
import UIKit

struct PersonCreditViewModel {
    var detailAttributedString: NSMutableAttributedString
    var year: String

    init(credit: PersonCastCredit) {
        
        let date: Date?
        let resultString = NSMutableAttributedString()
        
        switch credit.mediaType {
        case .tv:
            date = credit.firstAirDate
            if let title = credit.name {
                let mediaTitle = NSMutableAttributedString(string: title, attributes: [
                    .font : UIFont.systemFont(ofSize: 16, weight: .semibold),
                    .foregroundColor: UIColor.label
                ])
                resultString.append(mediaTitle)
            }
        default: // assume it's a movie
            date = credit.releaseDate
            if let title = credit.title {
                let mediaTitle = NSMutableAttributedString(string: title, attributes: [
                    .font : UIFont.systemFont(ofSize: 16, weight: .semibold),
                    .foregroundColor: UIColor.label
                ])
                resultString.append(mediaTitle)
            }
        }
        
        if let date = date, date != Date.distantPast {
            let year = Calendar.current.component(.year, from: date)
            self.year = String(year)
        } else {
            self.year = "-"
        }

        if let character = credit.character, character != "" {
            let connective = NSMutableAttributedString(string: " as ", attributes: [
                .font : UIFont.systemFont(ofSize: 14, weight: .regular),
                .foregroundColor: UIColor.secondaryLabel
            ])
            resultString.append(connective)
            
            let characterTitle = NSMutableAttributedString(string: character, attributes: [
                .font : UIFont.systemFont(ofSize: 16, weight: .regular),
                .foregroundColor: UIColor.label
            ])
            resultString.append(characterTitle)
        }
        
        self.detailAttributedString = resultString
    }
    
    init(credit: PersonCrewCredit) {
        
        let date: Date?
        
        switch credit.mediaType {
        case .tv:
            date = credit.firstAirDate
        default:
            date = credit.releaseDate
        }
        
        if let date = date, date != Date.distantPast {
            let year = Calendar.current.component(.year, from: date)
            self.year = String(year)
        } else {
            self.year = "-"
        }
        
        let resultString = NSMutableAttributedString()
        
        if let title = credit.title {
            let mediaTitle = NSMutableAttributedString(string: title, attributes: [
                .font : UIFont.systemFont(ofSize: 16, weight: .semibold),
                .foregroundColor: UIColor.label
            ])
            resultString.append(mediaTitle)
        }
        
        if let job = credit.job {
            
            let connective = NSMutableAttributedString(string: " ... ", attributes: [
                .font : UIFont.systemFont(ofSize: 14, weight: .regular),
                .foregroundColor: UIColor.secondaryLabel
            ])
            resultString.append(connective)
            
            let jobTitle = NSMutableAttributedString(string: job, attributes: [
                .font : UIFont.systemFont(ofSize: 16, weight: .regular),
                .foregroundColor: UIColor.label
            ])
            resultString.append(jobTitle)
        }
        
        self.detailAttributedString = resultString
    }
}
