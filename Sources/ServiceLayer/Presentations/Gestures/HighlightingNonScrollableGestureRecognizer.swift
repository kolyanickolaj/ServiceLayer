//
//  HighlightingNonScrollableGestureRecognizer.swift
//  Tonywin
//
//  Created by Andrey on 7/2/23.
//

import UIKit

final class HighlightingNonScrollableGestureRecognizer: NonScrollableGestureRecognizer, UIGestureRecognizerDelegate {

    private let handler: ((_ recognizer: UIGestureRecognizer) -> Void)?
    private let excludedViewTypes: [AnyClass]

    init(handler: ((_ recognizer: UIGestureRecognizer) -> Void)?,
         excludedViewTypes: [AnyClass] = [AnyClass]()) {
        self.handler = handler
        self.excludedViewTypes = excludedViewTypes
        super.init(target: nil, action: nil)
        delegate = self
        self.addTarget(self, action: #selector(handleHighlighting(_:)))
    }

    @objc private func handleHighlighting(_ gesture: UIGestureRecognizer) {
        handler?(gesture)
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let touchView = touch.view else { return false }
        if !excludedViewTypes.isEmpty {
            let isKindOfView = excludedViewTypes.contains { touchView.isKind(of: $0) }
            if isKindOfView {
                return false
            }
            for superview in touchView.superviews {
                for excludedViewType in excludedViewTypes {
                    if superview.isKind(of: excludedViewType) {
                        return false
                    }
                }
            }
        }

        return !(touchView.allSubviewsOf(type: UIButton.self).contains(where: {
            $0.bounds.contains(touch.location(in: touchView))
        }))
    }
}
