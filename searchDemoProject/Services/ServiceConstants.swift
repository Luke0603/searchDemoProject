//
//  ServiceConstants.swift
//  searchDemoProject
//
//  Created by 陳博竣 on 2020/7/26.
//  Copyright © 2020 Luke. All rights reserved.
//

import Foundation

class ServiceConstants: NSObject {
    
    static let APIScheme = "https"
    static let APIHost = "api.flickr.com"
    static let APIPath = "/services/rest"
    static let APIKey = Bundle.main.object(forInfoDictionaryKey: "APIKey") as? String
    
    static let APIparameters = [
        "method" : "flickr.photos.search",
        "format" : "json",
        "nojsoncallback" : "1"
//        "extras" : "url_m"
    ]
    
    static let imageURL = "https://farm%d.staticflickr.com/%@/%@_%@_q.jpg"
}
