//
//  Webservice.swift
//  searchDemoProject
//
//  Created by 陳博竣 on 2020/7/23.
//  Copyright © 2020 Luke. All rights reserved.
//

import Foundation

class Webservice: NSObject {
    static let shared = Webservice()
    
    func searchUrl(SearchKeyword keyword: String, DisplayNo displayNo: String, PageNo pageNo: String) -> URL? {
        var components = URLComponents()
        components.scheme = ServiceConstants.APIScheme
        components.host = ServiceConstants.APIHost
        components.path = ServiceConstants.APIPath
        
        components.queryItems = self.queryItems(with: ServiceConstants.APIparameters)
        components.queryItems?.append(URLQueryItem(name: "api_key", value: ServiceConstants.APIKey))
        components.queryItems?.append(URLQueryItem(name: "text", value: keyword))
        components.queryItems?.append(URLQueryItem(name: "per_page", value: displayNo))
        components.queryItems?.append(URLQueryItem(name: "page", value: pageNo))
        
        return components.url
    }
    
    private func queryItems(with parameters: [String : String]) -> [URLQueryItem] {
        return parameters.map {
            URLQueryItem(name: $0.0, value: $0.1)
        }
    }
    
    func flickrSearch(with searchURL: URL, completion: @escaping (Photos?) -> ()) {
        
        print("URL===========>\(searchURL)")
        let request = URLRequest(url: searchURL)
        
        NetworkManager.shared.request(request) { (result) in
            if let model = self.processResponse(result) {
                if let stat = model.stat, stat.uppercased().contains("OK") {
                    return completion(model.photos)
                } else {
                    print("SearchResults Model Stat Not OK!")
                    return completion(nil)
                }
            } else {
                print("SearchResults Model Error!")
                return completion(nil)
            }
        }
    }
    
    func processResponse(_ data: Data) -> SearchResults? {
        do {
            let responseModel = try JSONDecoder().decode(SearchResults.self, from: data)
            return responseModel
        } catch {
            print("Data parsing error: \(error.localizedDescription)")
            return nil
        }
    }
}
