//
//  URLErrorMethodProposer.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 12/22/23.
//

import Foundation

public class URLErrorMethodProposer: MethodProposing {
    
    public func proposeMethod(toHandle error: Error) -> Proposition? {
        switch error {
        case let error as NSError where error.domain == NSURLErrorDomain:
            return proposeMethod(nsError: error)
        default:
            return nil
        }
    }
    
    public init() { }
}

// MARK: - Supporting methods

private extension URLErrorMethodProposer {
    func systemAlertMethod(withMessage message: String) -> Proposition {
        let config = SystemAlertConfiguration(
            title: Localization.defaultErrorTitle.localized,
            message: message,
            actionTitle: Localization.ok.localized
        )
        
        return .single(.systemAlert(config))
    }
    
    func proposeMethod(nsError: NSError) -> Proposition? {
        switch nsError.code {
        case NSURLErrorUserAuthenticationRequired:
            return systemAlertMethod(withMessage: Localization.authRequired.localized)
        case NSURLErrorCancelled:
            return .single(.ignore)
        case NSURLErrorCannotFindHost, NSURLErrorDNSLookupFailed:
            return systemAlertMethod(withMessage: Localization.cantFindHost.localized)
        case NSURLErrorTimedOut, NSURLErrorCannotConnectToHost,
             NSURLErrorResourceUnavailable, NSURLErrorRedirectToNonExistentLocation:
            return systemAlertMethod(withMessage: Localization.resourceUnavailable.localized)
        case NSURLErrorNetworkConnectionLost, NSURLErrorNotConnectedToInternet:
            return systemAlertMethod(withMessage: Localization.internetConnectionLost.localized)
        default:
            return systemAlertMethod(withMessage: nsError.localizedDescription)
        }
    }
}
