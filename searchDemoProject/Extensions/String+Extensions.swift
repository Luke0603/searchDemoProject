//
//  String+Extensions.swift
//  searchDemoProject
//
//  Created by 陳博竣 on 2020/7/25.
//  Copyright © 2020 Luke. All rights reserved.
//

import Foundation

// 把空白鍵也判斷為空字串
extension String {
    var isBlank: Bool {
        let trimmedStr = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedStr.isEmpty
    }
}
