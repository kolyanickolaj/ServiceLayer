//
//  CompoundMethodProposer.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 12/22/23.
//

import Foundation

open class CompoundMethodProposer: MethodProposing {
    
    private let proposers: [MethodProposing]
    
    public init(proposers: [MethodProposing]) {
        self.proposers = proposers
    }
    
    // MARK: - MethodProposing
    
    public func proposeMethod(toHandle error: Error) -> Proposition? {
        for proposer in proposers {
            if let method = proposer.proposeMethod(toHandle: error) {
                return method
            }
        }
        
        return nil
    }
}
