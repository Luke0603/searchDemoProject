//
//  SearchResults.swift
//  searchDemoProject
//
//  Created by 陳博竣 on 2020/7/25.
//  Copyright © 2020 Luke. All rights reserved.
//

import Foundation

// MARK: - SearchResults
struct SearchResults: Codable {
    let photos: Photos?
    let stat: String?
}

// MARK: - Photos
struct Photos: Codable {
    let page, pages, perpage: Int
    let total: String
    let photo: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let id, owner, secret, server: String
    let farm: Int
    var title: String
    let ispublic, isfriend, isfamily: Int

    enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, farm, title, ispublic, isfriend, isfamily
    }
    
    var imageURL: String {
        let urlString = String(format: ServiceConstants.imageURL, farm, server, id, secret)
        return urlString
    }
}
