//
//  PaggingFlowLayout.swift
//  CrimeATravel
//
//  Created by Murad Ibrohimov on 13.11.22.
//  Copyright © 2022 CrimeATravel. All rights reserved.
//

import UIKit

class PaggingFlowLayout: UICollectionViewFlowLayout {

    var velocityPerPage: CGFloat = 2
    var numberOfItemsPerPage: CGFloat = 1
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return proposedContentOffset }

        let pageLength: CGFloat
        let approxPage: CGFloat
        let currentPage: CGFloat
        let speed: CGFloat

        if scrollDirection == .horizontal {
            pageLength = (itemSize.width + minimumLineSpacing) * numberOfItemsPerPage
            approxPage = collectionView.contentOffset.x / pageLength
            speed = velocity.x
        } else {
            pageLength = (itemSize.width + minimumLineSpacing) * numberOfItemsPerPage
            approxPage = collectionView.contentOffset.y / pageLength
            speed = velocity.y
        }

        if speed < 0 {
            currentPage = ceil(approxPage)
        } else if speed < 0 {
            currentPage = floor(approxPage)
        } else {
            currentPage = round(approxPage)
        }

        guard speed != 0 else {
            if scrollDirection == .horizontal {
                return CGPoint(x: currentPage * pageLength, y: 0)
            } else {
                return CGPoint(x: 0, y: currentPage * pageLength)
            }
        }

        var nextPage: CGFloat = currentPage + (speed > 0 ? 1 : -1)

        let increment = speed / velocityPerPage
        nextPage += (speed < 0) ? ceil(increment) : floor(increment)

        if scrollDirection == .horizontal {
            return CGPoint(x: nextPage * pageLength, y: 0)
        } else {
            return CGPoint(x: 0, y: nextPage * pageLength)
        }
    }
}
