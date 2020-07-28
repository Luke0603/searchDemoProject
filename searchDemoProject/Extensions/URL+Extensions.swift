//
//  URL+Extensions.swift
//  searchDemoProject
//
//  Created by 陳博竣 on 2020/7/23.
//  Copyright © 2020 Luke. All rights reserved.
//

import Foundation

extension URL {
    
    static var base: String {
        return "https://guarded-retreat-82533.herokuapp.com"
    }
    
    static var orders: URL? {
        return URL(string: base + "/orders")
    }
    
}
