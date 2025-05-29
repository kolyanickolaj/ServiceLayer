//
//  AppErrorMethodProposer.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 29.05.25.
//

import Foundation

public final class AppErrorMethodProposer: MethodProposing {
    public func proposeMethod(toHandle error: Error) -> Proposition? {
        switch error {
        case is UnauthorizedError:
            return .single(.logout)
        case is ClientError:
            return systemAlertMethod(withMessage: error.localizedDescription)
        case let error as LoginError:
            switch error.apiCode {
            case let x where x == .secondFactorAuth:
                return .single(
                    .custom(
                        LoginErrors.secondFactorAuth(
                            error: "You need to confirm authorization, check your email"
                        )
                    )
                )
            case let x where x == .invalidCreds:
                return .single(
                    .custom(
                        LoginErrors.invalidCreds(
                            remote: "You have \(error.attributes["remainingLoginAttempts"] ?? "") attempts left",
                            local: "Login or password entered incorrectly"
                        )
                    )
                )
            default:
                return .single(
                    .custom(
                        LoginErrors.default(
                            remote: error.localizedDescription
                        )
                    )
                )
            }
        case let error as SignUpError:
            let messages = error.fieldsAttributes.map { "\($0.message) \($0.name)" }
            return .single(.showCustomAlert(title: error.message, messages: messages))
        case let error as DefaultErrors:
            return systemAlertMethod(withMessage: error.localizedDescription)
        case let error as ServerErrors:
            return systemAlertMethod(withMessage: error.localizedDescription)
        case let error as NSError where error.domain == NSURLErrorDomain:
            return proposeMethod(toHandle: error)
        case let error as Network.URLSessionError:
            return proposeMethod(toHandle: error)
        default:
            return nil
        }
    }
}

// MARK: - Supporting methods

private extension AppErrorMethodProposer {
    func systemAlertMethod(withMessage message: String) -> Proposition {
        let config = SystemAlertConfiguration(
            title: Localization.defaultErrorTitle.localized,
            message: message,
            actionTitle: Localization.ok.localized
        )
        
        return .single(.systemAlert(config))
    }
    
    func proposeMethod(toHandle sessionError: Network.URLSessionError) -> Proposition? {
        switch sessionError {
        case .noRequest(let error):
            return systemAlertMethod(withMessage: error.localizedDescription)
        case .server(let statusCode, _, _):
            switch statusCode {
            case .serverError(let code) where code == 503:
                return systemAlertMethod(withMessage: Localization.serviceUnavailable.localized)
            default:
                return systemAlertMethod(withMessage: Localization.somethingWentWrongError.localized)
            }
        case .noData:
            return systemAlertMethod(withMessage: Localization.somethingWentWrongError.localized)
        case .url(let uRLError):
            return proposeMethod(nsError: uRLError as NSError)
        case .badResponse:
            return systemAlertMethod(withMessage: Localization.somethingWentWrongError.localized)
        case .retry(let error, _):
            return systemAlertMethod(withMessage: error.localizedDescription)
        case .cancelled:
            return systemAlertMethod(withMessage: Localization.somethingWentWrongError.localized)
        }
    }
    
    func proposeMethod(nsError: NSError) -> Proposition? {
        switch nsError.code {
        case NSURLErrorUserAuthenticationRequired:
            return systemAlertMethod(withMessage: "Authorization required")
        case NSURLErrorCancelled:
            return .single(.ignore)
        case NSURLErrorCannotFindHost, NSURLErrorDNSLookupFailed:
            return systemAlertMethod(withMessage: "Can't find host")
        case NSURLErrorTimedOut, NSURLErrorCannotConnectToHost,
             NSURLErrorResourceUnavailable, NSURLErrorRedirectToNonExistentLocation:
            return systemAlertMethod(withMessage: "Resource Unavailable")
        case NSURLErrorNetworkConnectionLost, NSURLErrorNotConnectedToInternet:
            return systemAlertMethod(withMessage: "Internet Connection Lost")
        default:
            return systemAlertMethod(withMessage: nsError.localizedDescription)
        }
    }
}
