//
//  CGPoint+Velocity.swift
//  Tonywin
//
//  Created by Vladislav Pavlov on 13.11.2023.
//

import UIKit

extension UIPanGestureRecognizer {
    func projectedLocation(decelerationRate: UIScrollView.DecelerationRate) -> CGPoint {
        let velocityOffset = velocity(in: view).projectedOffset(decelerationRate: .normal)
        let projectedLocation = location(in: view!) + velocityOffset
        return projectedLocation
    }
}

extension CGPoint {
    func projectedOffset(decelerationRate: UIScrollView.DecelerationRate) -> CGPoint {
        return CGPoint(
            x: x.projectedOffset(decelerationRate: decelerationRate),
            y: y.projectedOffset(decelerationRate: decelerationRate)
        )
    }
    
    static func + (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(
            x: left.x + right.x,
            y: left.y + right.y
        )
    }
}

extension CGFloat {
    func projectedOffset(decelerationRate: UIScrollView.DecelerationRate) -> CGFloat {
        let multiplier = 1 / (1 - decelerationRate.rawValue) / 1000
        return self * multiplier
    }
}
