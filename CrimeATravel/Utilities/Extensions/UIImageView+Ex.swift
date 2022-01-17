//
//  UIImageView+Ex.swift
//  CrimeATravel
//
//  Created by Murad Ibrohimov on 13.11.22.
//  Copyright © 2022 CrimeATravel. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func loadImage(_ url: URL?, needOptions: Bool = true,
                   needActivityIndicator: Bool = true,
                   placeholderImage: UIImage? = nil,
                   completion: (() -> Void)? = nil) {
        
        guard let url = url else {
            image = placeholderImage
            return
        }
        
        self.kf.indicatorType = needActivityIndicator ? .activity : .none
        
        let options: KingfisherOptionsInfo? = !needOptions ? nil :
        [.scaleFactor(UIScreen.main.scale), .transition(.fade(0.3)), .cacheOriginalImage]
        
        self.kf.setImage(with: url, placeholder: placeholderImage, options: options) { _ in
            completion?()
        }
    }
    
}
