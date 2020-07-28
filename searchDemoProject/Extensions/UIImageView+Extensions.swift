//
//  UIImageView+Extensions.swift
//  searchDemoProject
//
//  Created by 陳博竣 on 2020/7/26.
//  Copyright © 2020 Luke. All rights reserved.
//

import Foundation
import UIKit

fileprivate var imgCache = [String : UIImage]()

extension UIImageView {
    func loadImageUsingCache(with urlString: String) {
        self.image = nil
        
        if let cachedImage = imgCache[urlString] {
            DispatchQueue.main.async {
                self.image = cachedImage
            }
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            let photoImage = UIImage(data: data)
            
            imgCache[url.absoluteString] = photoImage
            DispatchQueue.main.async {
               self.image = photoImage
            }
        }
        task.resume()
    }
}
