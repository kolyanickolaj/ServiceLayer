//
//  ErrorDispatcherPreferences.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 12/22/23.
//

import Foundation

extension ErrorDispatcher {
    enum TrailingProposer {
        /**
         No trailing proposer will be used.
         */
        case none
        
        /**
         DefaultMethodProposer will be used as trailing one, thereby all unhandled errors will be
         handled by showing system alert with generic message.
         */
        case `default`
        
        /**
         DebugMethodProposer will be used as trailing one, thereby all unhandled errors will be
         handled by showing system alert with error details.
         */
        case debug
    }
    
    struct Preferences {
        var trailingProposer: TrailingProposer = .`default`
    }
}
