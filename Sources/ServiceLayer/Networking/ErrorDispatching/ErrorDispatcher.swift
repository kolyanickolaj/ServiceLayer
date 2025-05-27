//
//  ErrorDispatcher.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 12/22/23.
//

import Foundation

public protocol MethodExecutor: AnyObject {
    func execute(method: ErrorHandlingMethod)
}

public protocol IErrorDispatcher: AnyObject {
    var methodExecutionObserver: ObservingSubject<ErrorHandlingMethod> { get }
    func handle(error: Error)
}

public final class ErrorDispatcher: IErrorDispatcher {
   
    #if DEBUG
    static var preferences: Preferences = Preferences(trailingProposer: .debug)
    #else
    static var preferences: Preferences = Preferences(trailingProposer: .default)
    #endif
    
    public let methodExecutionObserver = ObservingSubject<ErrorHandlingMethod>()
    
    // MARK: - Private properties
    
    private let proposer: MethodProposing
    private let modifier: ErrorModifying?
    private let translator: ErrorModifying?
    private let _preferences: Preferences
    
    // MARK: - Initializer
    
    public init(
        proposer: MethodProposing,
        modifier: ErrorModifying? = nil,
        translator: ErrorModifying? = nil
    ) {
        _preferences = type(of: self).preferences
        
        switch _preferences.trailingProposer {
        case .none:
            self.proposer = proposer
        case .`default`:
            self.proposer = CompoundMethodProposer(proposers: [
                proposer,
                DefaultMethodProposer()
            ])
        case .debug:
            self.proposer = CompoundMethodProposer(proposers: [
                proposer,
                DebugMethodProposer()
            ])
        }
        
        self.modifier = modifier
        self.translator = translator
    }
    
    // MARK: - Error handling
    
    public func handle(error: Error) {
        let modifiedError = modifier?.modify(error: error) ?? error
        let actualError = translator?.modify(error: modifiedError) ?? modifiedError

        #if DEBUG
        print(actualError)
        #endif
        
        guard let proposedMethod = proposer.proposeMethod(toHandle: actualError) else {
            print("Unhandled error \(error)")
            return
        }
        
        switch proposedMethod {
        case .single(let method):
            methodExecutionObserver.send(method)
        case .compound(let methods):
            for method in methods {
                methodExecutionObserver.send(method)
            }
        }
    }
}
