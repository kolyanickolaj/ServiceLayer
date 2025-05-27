//
//  Lazy.swift
//  Tonywin
//
//  Created by Andrey on 6/30/23.
//

import Foundation

final class Lazy<T> {

    enum State {
        case uninitialized(() -> T)
        case initialized(T)
    }

    private var state: State

    init(_ factory: @autoclosure @escaping () -> T) {
        state = .uninitialized(factory)
    }

    func get() -> T {
        switch state {
        case .uninitialized(let factory):
            let instance = factory()
            state = .initialized(instance)
            return instance
        case .initialized(let instance):
            return instance
        }
    }
}
