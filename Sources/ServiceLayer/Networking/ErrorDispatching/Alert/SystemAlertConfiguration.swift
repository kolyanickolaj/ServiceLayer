//
//  SystemAlertConfiguration.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 12/22/23.
//

import Foundation
import UIKit

public struct SystemAlertAction {
    
    public typealias Handler = (() -> Void)
    
    public let title: String?
    public let style: UIAlertAction.Style
    public let handler: Handler?
    
    public init(title: String?, style: UIAlertAction.Style, handler: Handler? = nil) {
        self.title = title
        self.style = style
        self.handler = handler
    }
}

public struct SystemAlertConfiguration {
    public let title: String?
    public let message: String?
    public let preferredStyle: UIAlertController.Style
    public let actions: [SystemAlertAction]
    
    public init(title: String?, message: String?,
         actions: [SystemAlertAction],
         preferredStyle: UIAlertController.Style = .alert) {
        self.title = title
        self.message = message
        self.preferredStyle = preferredStyle
        self.actions = actions
    }
    
    public init(title: String?, message: String?, actionTitle: String?,
         actionHandler: SystemAlertAction.Handler? = nil) {
        self.title = title
        self.message = message
        self.preferredStyle = .alert
        
        self.actions = [ SystemAlertAction(title: actionTitle, style: .default, handler: actionHandler) ]
    }
}
