//
//  WeakScriptHandler.swift
//  ServiceLayer
//
//  Created by Andrey Polyashev on 3/21/24.
//

import WebKit

public class WeakScriptHandler: NSObject, WKScriptMessageHandler {
    
    weak var handler: WKScriptMessageHandler? = nil

    public init(_ aHandler: WKScriptMessageHandler) {
        self.handler = aHandler
    }

    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        handler?.userContentController(userContentController, didReceive: message)
    }
}
