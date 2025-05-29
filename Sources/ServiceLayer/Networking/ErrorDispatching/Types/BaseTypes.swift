//
//  BaseTypes.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 12/22/23.
//

import Foundation

public protocol CustomHandlingMethod {}

public enum Proposition {
    case single(ErrorHandlingMethod)
    case compound([ErrorHandlingMethod])
}

public enum ErrorHandlingMethod {
    case ignore
    case logout
    case systemAlert(SystemAlertConfiguration)
    case inViewError(remote: String, local: String)
    case showCustomAlert(title: String, messages: [String])
    case custom(CustomHandlingMethod)
}

public protocol MethodProposing {
    func proposeMethod(toHandle error: Error) -> Proposition?
}

public protocol ErrorExtracting {
    func extract(
        request: RequestResource,
        error: Error?
    ) -> Error?
}

public protocol ErrorModifying {
    func modify(error: Error) -> Error?
}
