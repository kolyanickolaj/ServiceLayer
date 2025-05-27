//
//  Observing.swift
//  Tonywin
//
//  Created by Andrey on 7/2/23.
//

import Foundation
import Combine

public typealias ObservingSubject<T> = PassthroughSubject<T, Never>
public typealias ObservingPublisher<T> = AnyPublisher<T, Never>
public typealias SubscriptionsBag = Set<AnyCancellable>
