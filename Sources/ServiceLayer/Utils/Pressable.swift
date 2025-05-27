//
//  Pressable.swift
//  Tonywin
//
//  Created by Andrey on 7/2/23.
//

import UIKit

public protocol Pressable: AnyObject {
    
    func enabledPressable(pressingView: UIView,
                          excludedViewTypes: [AnyClass],
                          completion: @escaping () -> Void)
    
    func disablePressable(pressingView: UIView)
}

extension Pressable where Self: UIView {

    public func disablePressable(pressingView: UIView) {
        removePreviousGestures(from: pressingView)
    }
    
    public func enabledPressable(pressingView: UIView,
                          excludedViewTypes: [AnyClass] = [],
                          completion: @escaping () -> Void) {

        removePreviousGestures(from: pressingView)

        let gesture = HighlightingNonScrollableGestureRecognizer(handler: { [weak self] gesture in
            self?.handleGesture(gesture, completion: completion)
        }, excludedViewTypes: excludedViewTypes)
        gesture.cancelsTouchesInView = false
        pressingView.addGestureRecognizer(gesture)
    }

    private func handleGesture(_ gesture: UIGestureRecognizer, completion: () -> Void) {
        switch gesture.state {
        case .possible, .changed:
            break
        case .began:
            self.animatePressStateChanged(pressed: true)
        case.ended:
            completion()
            fallthrough
        case .cancelled, .failed:
            self.animatePressStateChanged(pressed: false)
        default:
            break
        }
    }

    private func animatePressStateChanged(pressed: Bool) {
        let minScale = 0.9
        let toValue = pressed ? CATransform3DMakeScale(minScale, minScale, 1) : CATransform3DMakeScale(1, 1, 1)
        var duration = 0.1
        if let presentationLayer = layer.presentation() {
            let progress = (presentationLayer.transform.m11 - minScale) / (1 - minScale)
            duration = pressed ? duration * progress : duration * (1 - progress)
        }

        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: [.beginFromCurrentState, .curveLinear],
                       animations: { self.layer.transform = toValue })
    }

    private func removePreviousGestures(from view: UIView) {
        let gestures = view.gestureRecognizers ?? []
        gestures.filter {
            $0.isKind(of: HighlightingNonScrollableGestureRecognizer.self)
        }.forEach {
            view.removeGestureRecognizer($0)
        }
    }
}
