//
//  View+Shadow.swift
//  Tonywin
//
//  Created by Andrey on 7/3/23.
//

import UIKit

extension UIView {
    func dropShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.03
        layer.shadowRadius = 5
        layer.shadowOffset = .init(width: 0, height: 2)
    }
}
