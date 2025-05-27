//
//  IQueue.swift
//  Tonywin
//
//  Created by Andrey on 7/2/23.
//

import Foundation

public protocol IQueue {
    func async(group: DispatchGroup?,
               qos: DispatchQoS,
               flags: DispatchWorkItemFlags,
               execute work: @escaping @convention(block) () -> Void)
    func async(execute work: @escaping @convention(block) () -> Void)
}
extension IQueue {
    public func async(execute work: @escaping @convention(block) () -> Void) {
        async(group: nil, qos: .unspecified, flags: [], execute: work)
    }
}
