//
//  NetworkManager.swift
//  searchDemoProject
//
//  Created by 陳博竣 on 2020/7/26.
//  Copyright © 2020 Luke. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager: NSObject {

static let shared = NetworkManager()

    func request(_ request: URLRequest, completion: @escaping (Data) -> Void) {
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let data = data else {
                print("No data was returned by request")
                return
            }
            
            guard let stringResponse = String(data: data, encoding: String.Encoding.utf8) else { return }
            
            print("Respone: \(stringResponse)")
            
            return completion(data)
        }
        task.resume()
    }
}
