//
//  Pagging3DEffectFlowLayout.swift
//  Theeye
//
//  Created by Murad Ibrohimov on 13.11.21.
//  Copyright © 2021 Theeye. All rights reserved.//

import UIKit

enum Pagging3DEffectFlowLayoutSpacingMode {
    case fixed(spacing: CGFloat)
    case overlap(visibleOffset: CGFloat)
}

class Pagging3DEffectFlowLayout: UICollectionViewFlowLayout {
    
    struct LayoutState {
        var size: CGSize
        var direction: UICollectionView.ScrollDirection
        func isEqual(_ otherState: LayoutState) -> Bool {
            return self.size.equalTo(otherState.size) && self.direction == otherState.direction
        }
    }

    var velocityPerPage: CGFloat = 2
    var numberOfItemsPerPage: CGFloat = 1
    var sideItemScale: CGFloat = 0.8
    var sideItemAlpha: CGFloat = 0.75
    var sideItemShift: CGFloat = 0.0
    var spacingMode: Pagging3DEffectFlowLayoutSpacingMode = .fixed(spacing: 10)
    
    var state = LayoutState(size: CGSize.zero, direction: .horizontal)
    
    override func prepare() {
        super.prepare()
        let currentState = LayoutState(size: collectionView!.bounds.size, direction: scrollDirection)
        
        if !self.state.isEqual(currentState) {
            self.setupCollectionView()
            self.updateLayout()
            self.state = currentState
        }
    }
    
    private func setupCollectionView() {
        guard let collectionView = collectionView else { return }
        if collectionView.decelerationRate != UIScrollView.DecelerationRate.fast {
            collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        }
    }
    
    private func updateLayout() {
        guard let collectionView = collectionView else { return }
        
        let collectionSize = collectionView.bounds.size
        let isHorizontal = (scrollDirection == .horizontal)
        
        let yInset = (collectionSize.height - itemSize.height) / 2
        let xInset = (collectionSize.width - itemSize.width) / 2
        self.sectionInset = UIEdgeInsets.init(top: yInset, left: xInset, bottom: yInset, right: xInset)
        
        let side = isHorizontal ? itemSize.width : itemSize.height
        let scaledItemOffset =  (side - side * sideItemScale) / 2
        switch spacingMode {
        case .fixed(let spacing):
            minimumLineSpacing = spacing - scaledItemOffset
        case .overlap(let visibleOffset):
            let fullSizeSideItemOverlap = visibleOffset + scaledItemOffset
            let inset = isHorizontal ? xInset : yInset
            minimumLineSpacing = inset - fullSizeSideItemOverlap
        }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect),
              let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes]
        else { return nil }
        return attributes.map({ transformLayoutAttributes($0) })
    }
    
    private func transformLayoutAttributes(_ attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let collectionView = collectionView else { return attributes }
        let isHorizontal = (scrollDirection == .horizontal)
        
        let collectionCenter = isHorizontal ? collectionView.frame.size.width / 2 : collectionView.frame.size.height / 2
        let offset = isHorizontal ? collectionView.contentOffset.x : collectionView.contentOffset.y
        let normalizedCenter = (isHorizontal ? attributes.center.x : attributes.center.y) - offset
        
        let maxDistance = (isHorizontal ? itemSize.width : itemSize.height) + minimumLineSpacing
        let distance = min(abs(collectionCenter - normalizedCenter), maxDistance)
        let ratio = (maxDistance - distance)/maxDistance
        
        let alpha = ratio * (1 - sideItemAlpha) + sideItemAlpha
        let scale = ratio * (1 - sideItemScale) + sideItemScale
        let shift = (1 - ratio) * sideItemShift
        attributes.alpha = alpha
        attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        attributes.zIndex = Int(alpha * 10)
        
        if isHorizontal {
            attributes.center.y = attributes.center.y + shift
        } else {
            attributes.center.x = attributes.center.x + shift
        }
        
        return attributes
    }
    
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
    
    func swipeLeft() {
        guard let collectionView = collectionView else { return }
        let pageLength = (itemSize.width + minimumLineSpacing)
        let approxPage = collectionView.contentOffset.x / pageLength
        let nextPage = round(approxPage)
        let offset = CGPoint(x: (nextPage - 1) * pageLength, y: 0)
        collectionView.setContentOffset(offset , animated: true)
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    
    func swipeRigth() {
        guard let collectionView = collectionView else { return }
        let pageLength = (itemSize.width + minimumLineSpacing)
        let approxPage = collectionView.contentOffset.x / pageLength
        let nextPage = round(approxPage)
        let offset = CGPoint(x: (nextPage + 1) * pageLength, y: 0)
        if Int(nextPage + 1) < collectionView.numberOfItems(inSection: 0) {
            collectionView.setContentOffset(offset , animated: true)
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        }
    }
}
