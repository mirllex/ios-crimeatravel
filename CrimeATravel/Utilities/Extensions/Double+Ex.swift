//
//  Double+Ex.swift
//  Theeye
//
//  Created by Murad Ibrohimov on 13.11.21.
//  Copyright © 2021 Theeye. All rights reserved.
//

import Foundation

public extension Double {
  var cleanValue: String {
//    let newValue = self.rounded(toPlaces: 2)
//    if newValue.truncatingRemainder(dividingBy: 1) == .zero {
//      return String(format: "%.0f", self)
//    } else if newValue.truncatingRemainder(dividingBy: 0.1) < 0.1 {
//      return String(format: "%.1f", self)
//    } else if newValue.truncatingRemainder(dividingBy: 0.01) < 0.01 {
      return String(format: "%.2f", self)
//    }
//    return ""
  }
  
  var withoutZeros: String {
    return String(format: "%g", self)
  }
  
  func rounded(toPlaces places: Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return (self * divisor).rounded() / divisor
  }
}
