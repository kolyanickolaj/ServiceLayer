//
//  NonScrollableGestureRecognizer.swift
//  Tonywin
//
//  Created by Andrey on 7/2/23.
//

import UIKit

class NonScrollableGestureRecognizer: UIGestureRecognizer {

    private var initialTouchPoint: CGPoint?

    override func canPrevent(_ preventedGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        self.state = .began
        self.initialTouchPoint = touches.first?.location(in: view)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)

        guard let touchPoint = touches.first?.location(in: view),
              let initialTouchPoint else {
            self.state = .cancelled
            return
        }

        if abs(touchPoint.y - initialTouchPoint.y) > 10 || abs(touchPoint.x - initialTouchPoint.x) > 10 {
            self.state = .cancelled
        } else {
            self.state = .changed
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        self.state = .ended
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        self.state = .cancelled
    }

    override func reset() {
        super.reset()
        initialTouchPoint = nil
    }
}
