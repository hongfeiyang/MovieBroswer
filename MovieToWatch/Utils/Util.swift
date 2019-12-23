//
//  Util.swift
//  MovieToWatch
//
//  Created by Clark on 19/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

}

extension UIColor {
    
    static var contrastColor: UIColor {
        switch Constants.USER_INTERFACE_STYLE {
        case .dark:
            return UIColor.white
        case .light:
            return UIColor.black
        default:
            return UIColor.white
        }
    }
    
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
    
    func getComplementaryColor() -> UIColor {
        var d: Float = 0

        // Counting the perceptive luminance - human eye favors green color...
        let luminance = 0.299 * self.rgba.red + 0.587 * self.rgba.green + 0.114 * self.rgba.blue

        if (luminance > 0.5) {
            d = 0 // bright colors - black font
        }
        else {
           d = 255 // dark colors - white font
        }

        return UIColor(red: CGFloat(d/255), green: CGFloat(d/255), blue: CGFloat(d/255), alpha: 1);
    }
}

extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)

            do {
                let result = try decoder.decode(T.self, from: data)
                completionHandler(result, response, nil)
            } catch let error {
                print(error)
                completionHandler(nil, response, nil)
            }
            
            
            //completionHandler(result, response, nil)
        }
    }

    func movieDetailTask(with url: URL, completionHandler: @escaping (MovieMO?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
