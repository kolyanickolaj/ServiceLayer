//
//  UIView+Extensions.swift
//  Tonywin
//
//  Created by Andrey on 7/2/23.
//

import UIKit

extension UIView {

    func allSubviewsOf<T: UIView>(type: T.Type) -> [T] {
        var allSubviews = [T]()
        func getSubviews(view: UIView) {
            if let aView = view as? T {
                allSubviews.append(aView)
            }
            guard !view.subviews.isEmpty else { return }
            view.subviews.forEach { getSubviews(view: $0) }
        }
        getSubviews(view: self)
        return allSubviews
    }

    var superviews: Set<UIView> {
        var next = self
        var set = Set<UIView>()
        while let superview = next.superview {
            set.insert(superview)
            next = superview
        }
        return set
    }
    
    public convenience init(height: CGFloat) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    public convenience init(width: CGFloat) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true

    }
    
    public convenience init(width: CGFloat, height: CGFloat) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
}

extension UIView {

    public func setHiddenInSuperview(isHidden: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.isHidden = isHidden
            self.superview?.layoutIfNeeded()
        }
    }
}
