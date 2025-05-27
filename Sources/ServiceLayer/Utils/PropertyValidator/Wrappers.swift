//
//  File.swift
//  
//
//  Created by Alexandr Gaidukov on 08.12.2019.
//

import Combine
import Foundation

@propertyWrapper
public class Validated<Value> {

    private var _subject: Publishers.HandleEvents<PassthroughSubject<[Error], Never>>!
    private var subject: Publishers.HandleEvents<PassthroughSubject<[Error], Never>> {
        return _subject
    }

    private var subscribed: Bool = false
    private var validators: [AnyValidator<Value>]

    public var wrappedValue: Value? {
        didSet {
            if subscribed {
                subject.upstream.send(errors)
            }
        }
    }

    public init(wrappedValue value: Value?, _ validators: [AnyValidator<Value>]) {
        wrappedValue = value
        self.validators = validators
        _subject = PassthroughSubject<[Error], Never>()
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.subscribed = true
            })
    }

    public var projectedValue: Validated<Value> {
        self
    }

    public var publisher: AnyPublisher<[Error], Never> {
        subject.eraseToAnyPublisher()
    }

    public var errors: [Error] {
        var errors: [Error] = []
        validators.forEach {
            do {
                try $0.validate(value: wrappedValue)
            } catch {
                if let multipleError = error as? MultipleError {
                    errors.append(contentsOf: multipleError.errors)
                } else {
                    errors.append(error)
                }
            }
        }
        return errors
    }
}
