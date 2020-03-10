//
//  URLSessionInterceptor.swift
//  MovieToWatch
//
//  Created by Clark on 9/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import Foundation

class Interceptor {
    static let shared = Interceptor()
    
    fileprivate enum InterceptorError: String, Error {
        case StringEncodingError = "String Encoding Error"
        case NoDataError = "No Data Error"
    }
    
    func intercept(data: Data?) {
        do {
            guard let data = data else {throw InterceptorError.NoDataError}
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            guard let string = String(data: jsonData, encoding: .utf8) else {throw InterceptorError.StringEncodingError}
            print(string)
        } catch let error {
            print(error)
        }
    }
}
