//
//  UIViewController+Keyboard.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 9/29/23.
//

import UIKit
import Combine

extension UIViewController {
    
    public func subscribeKeyboard(safeAreaShouldImpact: Bool = true, handler: @escaping (CGFloat) -> Void ) {
        let keyboardWillOpen = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .map { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero }
            .map { $0.height }

        let keyboardWillHide = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .map { [weak self] _ in safeAreaShouldImpact ? self?.view.safeAreaInsets.bottom ?? .zero : .zero }

        _ = Publishers.Merge(keyboardWillOpen, keyboardWillHide)
            .subscribe(on: DispatchQueue.main)
            .map { [weak self] in $0 - (safeAreaShouldImpact ? (self?.view.safeAreaInsets.bottom ?? .zero) : .zero) }
            .sink(receiveValue: { offset in
                handler(offset)
            })
    }
}
