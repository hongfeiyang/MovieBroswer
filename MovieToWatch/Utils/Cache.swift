//
//  Cache.swift
//  MovieToWatch
//
//  Created by Clark on 19/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import Foundation
import UIKit

class Cache {
    static let shared = Cache()
    
    var imageCache = NSCache<NSString, UIImage>()
    
    func cacheImage(url: URL, completion: ((URL, UIImage) -> Void)?) {
        
        if let image = Cache.shared.imageCache.object(forKey: url.absoluteString as NSString) {
            completion?(url, image)
        } else {
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data, let image = UIImage(data: data) else { print("failed to get image data"); return}
                
                let screenWidth = UIScreen.main.bounds.width
                let height = screenWidth * 3/2
                let size = CGSize(width: screenWidth, height: height)
                let newImage = image.resizeImage(targetSize: size)
                
                Cache.shared.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                
                completion?(url, image)
                
            }.resume()
            
        }
    }
}
