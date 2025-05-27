//
//  UIColor+Image.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 9/7/23.
//

import UIKit

extension UIColor {
    
    public func image(width: Int = 1, height: Int = 1) -> UIImage {
        let size = CGSize(width: width, height: height)
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
