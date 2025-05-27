//
//  TransitionDriver.swift
//  Tonywin
//
//  Created by Vladislav Pavlov on 13.11.2023.
//

import UIKit

final class TransitionDriver: UIPercentDrivenInteractiveTransition {
    
    // MARK: - Public
    var direction: TransitionDirection = .present

    // MARK: - Private
    private weak var presentedController: UIViewController?
    private var panRecognizer: UIPanGestureRecognizer?
    
    private var maxTransition: CGFloat {
        return presentedController?.view.frame.height ?? 0
    }
    
    private var isRunning: Bool {
        return percentComplete != 0
    }
    
    // MARK: - Linking
    
    func link(to controller: UIViewController) {
        presentedController = controller
        let panRecognizer = UIPanGestureRecognizer(
            target: self,
            action: #selector(handle(recognizer:))
        )
        self.panRecognizer = panRecognizer
        presentedController?.view.addGestureRecognizer(panRecognizer)
    }
    
    // MARK: - Override
    
    override var wantsInteractiveStart: Bool {
        get {
            switch direction {
            case .present:
                return false
            case .dismiss:
                let gestureIsActive = panRecognizer?.state == .began
                return gestureIsActive
            }
        }
        set {
        }
    }
    
    // MARK: - Directrion
    
    @objc private func handle(recognizer r: UIPanGestureRecognizer) {
        switch direction {
        case .present:
            handlePresentation(recognize: r)
        case .dismiss:
            handleDismiss(recognizer: r)
        }
    }
}

// MARK: - Gesture handling

private extension TransitionDriver {
    
    func handlePresentation(recognize r: UIPanGestureRecognizer) {
        switch r.state {
        case .began:
            pause()
        case .changed:
            let increment = -r.incrementToBottom(maxTranslation: maxTransition)
            update(percentComplete + increment)
        case   .ended,
                .cancelled:
            if r.isProjectedToDownHalf(maxTransition: maxTransition) {
                cancel()
            } else {
                finish()
            }
        case .failed:
            cancel()
        default:
            break
        }
    }
    
    func handleDismiss(recognizer r: UIPanGestureRecognizer) {
        switch r.state {
        case .began:
            pause()
            if !isRunning {
                presentedController?.dismiss(animated: true)
            }
        case .changed:
            update(percentComplete + r.incrementToBottom(maxTranslation: maxTransition))
        case    .ended,
                .cancelled:
            if r.isProjectedToDownHalf(maxTransition: maxTransition) {
                finish()
            } else {
                cancel()
            }
        case .failed:
            cancel()
        default:
            break
        }
    }
}

// MARK: Extension UIPanGestureRecognizer

private extension UIPanGestureRecognizer {
    
    func isProjectedToDownHalf(maxTransition: CGFloat) -> Bool {
        let endLocation = projectedLocation(decelerationRate: .fast)
        let isPresentationCompleted = endLocation.y > maxTransition / 2
        return isPresentationCompleted
    }
    
    func incrementToBottom(maxTranslation: CGFloat) -> CGFloat {
        let translation = self.translation(in: view).y
        setTranslation(.zero, in: nil)
        let percentIncrement = translation / maxTranslation
        return percentIncrement
    }
}
