//
//  Date+Ex.swift
//  Theeye
//
//  Created by Murad Ibrohimov on 13.11.21.
//  Copyright © 2021 Theeye. All rights reserved.
//

import Foundation

extension Date {
    
    func getAsString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
    
    func getFullAsString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy, HH:mm"
        return formatter.string(from: self)
    }
    
    func getAsInt() -> Int {
        Int(self.timeIntervalSince1970)
    }
}
