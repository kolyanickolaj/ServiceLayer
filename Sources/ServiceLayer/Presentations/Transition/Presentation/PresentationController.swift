//
//  PresentationController.swift
//  Tonywin
//
//  Created by Vladislav Pavlov on 13.11.2023.
//

import UIKit

public class PresentationController: UIPresentationController {
    
    public enum TargetHeight {
        case custom(CGFloat)
        case fullScreen
        case autolyaout
    }
    
    // MARK: - Properties
    
    private let popupHeight: TargetHeight
    private let presentedVC: UIViewController
    private let presentingVC: UIViewController
    var driver: TransitionDriver!
    
    // MARK: - Init
    
    public init(
        popupHeight: TargetHeight,
        presentedVC: UIViewController,
        presentingVC: UIViewController
    ) {
        self.popupHeight = popupHeight
        self.presentedVC = presentedVC
        self.presentingVC = presentingVC
        super.init(presentedViewController: presentedVC, presenting: presentingVC)
    }
    
    public override var shouldPresentInFullscreen: Bool {
        return false
    }
    
    public override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    public override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView else { return .zero }
        let bounds = containerView.bounds
        
        switch popupHeight {
        case .custom(let height):
            let needHeight = bounds.height - height
            return CGRect(x: 0, y: needHeight, width: bounds.width, height: height)
        case .fullScreen:
            return CGRect(origin: .zero, size: bounds.size)
        case .autolyaout:
            let fittingSize = CGSize(
                width: bounds.width,
                height: UIView.layoutFittingCompressedSize.height
            )
            let targetHeight = presentedView?.systemLayoutSizeFitting(
                fittingSize,
                withHorizontalFittingPriority: .required,
                verticalFittingPriority: .defaultLow
            ).height ?? .zero
            
            let y = bounds.height - targetHeight
            return .init(x: .zero, y: y, width: bounds.width, height: targetHeight)
        }
    }
    
    public override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        if let presentedView {
            containerView?.addSubview(presentedView)
        }
    }
    
    public override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    public override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        if completed {
            driver.direction = .dismiss
        }
    }
}
