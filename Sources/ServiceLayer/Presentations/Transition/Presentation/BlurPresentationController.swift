//
//  BlurPresentationController.swift
//  Tonywin
//
//  Created by Vladislav Pavlov on 13.11.2023.
//

import UIKit

final class BlurPresentationController: PresentationController {
    
    private lazy var dimnView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        view.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(tapForDismiss))
        )
        view.alpha = 0
        return view
    }()
    
    // MARK: - Action for dismiss
    
    @objc private func tapForDismiss() {
        presentedViewController.dismiss(animated: true)
    }
    
    // MARK: - Begin Animation
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        containerView?.insertSubview(dimnView, at: 0)
        performAlongsideTransitionIfPossible { [weak self] in
            self?.dimnView.alpha = 1
        }
    }
    
    // MARK: - Setup size for BlurView
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        dimnView.frame = containerView!.frame
    }
    
    // MARK: - End Animation
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        if !completed {
            self.dimnView.removeFromSuperview()
        }
    }
    
    // MARK: - Begin dismiss
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        performAlongsideTransitionIfPossible { [weak self] in
            self?.dimnView.alpha = 0
        }
    }
    
    // MARK: - End dismiss
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        if completed {
            self.dimnView.removeFromSuperview()
        }
    }
    
    // MARK: - Animation
    
    private func performAlongsideTransitionIfPossible(_ completion: @escaping () -> Void) {
        guard let coordinator = self.presentedViewController.transitionCoordinator else {
            completion()
            return
        }
        coordinator.animate(
            alongsideTransition: { _ in completion() },
            completion: nil
        )
    }
}
