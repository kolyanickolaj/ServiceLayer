//
//  PanelTransition.swift
//  Tonywin
//
//  Created by Vladislav Pavlov on 13.11.2023.
//

import UIKit

public final class PanelTransition: NSObject, UIViewControllerTransitioningDelegate {
    
    public enum PresentingStyle {
        case normal, blur
    }
    
    // MARK: - Properties
    
    /// PresentingViewController style
    private let presentingStyle: PresentingStyle
    /// Popup height
    private let popupHeight: PresentationController.TargetHeight
    private let driver = TransitionDriver()
    
    // MARK: - Init
    
    public init(presentingStyle: PresentingStyle, popupHeight: PresentationController.TargetHeight) {
        self.presentingStyle = presentingStyle
        self.popupHeight = popupHeight
    }
    
    // MARK: - Presentation controller
    
    public func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController) -> UIPresentationController? {
            driver.link(to: presented)
            
            let presentedController: PresentationController
            
            switch self.presentingStyle {
            case .normal:
                presentedController = PresentationController(
                    popupHeight: popupHeight,
                    presentedVC: presented,
                    presentingVC: presenting ?? source)
            case .blur:
                presentedController = BlurPresentationController(
                    popupHeight: popupHeight,
                    presentedVC: presented,
                    presentingVC: presenting ?? source)
            }
            
            presentedController.driver = driver
            
            return presentedController
        }
    
    // MARK: - Animation
    
    public func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            PresentAnimation()
        }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        DismissAnimation()
    }
    
    // MARK: - Interection
    
    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        driver
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        driver
    }
}
