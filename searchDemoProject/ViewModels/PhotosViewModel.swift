//
//  PhotosViewModel.swift
//  searchDemoProject
//
//  Created by 陳博竣 on 2020/7/25.
//  Copyright © 2020 Luke. All rights reserved.
//

import Foundation
import UIKit

class PhotosViewModel: NSObject {
    
    private(set) var photoArray = [Photo]()
    private var searchText = ""
    private(set) var searchNo = ""
    private var pageNo = 1
    private var totalPageNo = 1
    
    var dataUpdated: (() -> Void)?
    
    func search(SearchWord word: String, DisplayNo no: String, completion: @escaping () -> Void) {
        searchText = word
        searchNo = no
        photoArray.removeAll()
        fetchResults(completion: completion)
    }
    
    func loadNextPage(completion: @escaping () -> Void) {
        if pageNo < totalPageNo {
            pageNo += 1
            fetchResults {
                completion()
            }
        } else {
            completion()
        }
    }
    
    private func fetchResults(completion: @escaping () -> Void) {
        
        guard let url = Webservice.shared.searchUrl(SearchKeyword: self.searchText, DisplayNo: self.searchNo, PageNo: String(self.pageNo)) else {
            print("Failed to fetch flickr data!")
            return
        }
        
        Webservice.shared.flickrSearch(with: url) { [weak self] (photos) in
            
            guard let self = self, let photos = photos else { return }
            
            self.totalPageNo = photos.pages
            self.photoArray.append(contentsOf: photos.photo)
            DispatchQueue.main.async {
                self.dataUpdated?()
            }
            completion()
        }
    }
}
