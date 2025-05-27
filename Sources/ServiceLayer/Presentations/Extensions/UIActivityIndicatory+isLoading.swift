//
//  ActivityIndicatory+isLoading.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 11/15/23.
//

import UIKit

extension UIActivityIndicatorView {
    
    public var isLoading: Bool {
        set {
            if newValue {
                startAnimating()
            } else {
                stopAnimating()
            }
        }
        get {
            return isAnimating
        }
    }
}
