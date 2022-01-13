//
//  UIImage+Ex.swift
//  Theeye
//
//  Created by Murad Ibrohimov on 13.11.21.
//  Copyright © 2021 Theeye. All rights reserved.
//

import UIKit

extension UIImage {
    
    func resizeImage(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
}
