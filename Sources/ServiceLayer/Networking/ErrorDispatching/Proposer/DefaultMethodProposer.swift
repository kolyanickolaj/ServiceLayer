//
//  DefaultMethodProposer.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 12/22/23.
//

import Foundation

public class DefaultMethodProposer: MethodProposing {
    
    public func proposeMethod(toHandle error: Error) -> Proposition? {
        let config = SystemAlertConfiguration(
            title: Localization.defaultErrorTitle.localized,
            message: error.localizedDescription,
            actionTitle: Localization.ok.localized
        )
        
        return .single(.systemAlert(config))
    }
}
