//
//  StackView+Axis.swift
//  Tonywin
//
//  Created by Andrey on 7/2/23.
//

import UIKit

extension UIStackView {

    public convenience init(axis: NSLayoutConstraint.Axis, spacing: CGFloat = 0) {
        self.init()
        self.axis = axis
        self.spacing = spacing
    }
}
