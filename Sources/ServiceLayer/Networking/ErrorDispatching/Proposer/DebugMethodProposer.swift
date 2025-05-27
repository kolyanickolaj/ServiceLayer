//
//  DebugMethodProposer.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 12/22/23.
//

import Foundation

public class DebugMethodProposer: MethodProposing {
        
    public func proposeMethod(toHandle error: Error) -> Proposition? {
        let message = error.localizedDescription
        
        let config = SystemAlertConfiguration(
            title: NSLocalizedString("defaultErrorTitle", comment: ""),
            message: message,
            actionTitle: NSLocalizedString("OK", comment: "")
        )
        
        return .single(.systemAlert(config))
    }
}
