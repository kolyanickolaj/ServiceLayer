//
//  Container.swift
//  Tonywin
//
//  Created by Andrey on 7/31/23.
//

import Swinject

public protocol DIResolver {
    func resolve<Service>(_ serviceType: Service.Type) -> Service
    func resolve<Service>() -> Service
}

public protocol DIRegister {
    @discardableResult
    func register<Service>(
        _ serviceType: Service.Type,
        name: String?,
        factory: @escaping (DIResolver) -> Service
    ) -> ServiceEntry<Service>
}

public final class Container: DIResolver, DIRegister {

    private let container = Swinject.Container()

    public init() {}
    
    // MARK: - DIRegister

    @discardableResult
    public func register<Service>(
        _ serviceType: Service.Type,
        name: String? = nil,
        factory: @escaping (DIResolver) -> Service
    ) -> ServiceEntry<Service> {
        return container.register(serviceType) { _ in
            factory(self)
        }
    }

    // MARK: - DIResolver

    public func resolve<Service>(_ serviceType: Service.Type) -> Service {
        guard let resolved = container.resolve(serviceType) else {
            fatalError("\(Service.self) can't be resolved. Register first.")
        }
        
        return resolved
    }

    public func resolve<Service>() -> Service {
        guard let resolved = container.resolve(Service.self) else {
            fatalError("\(Service.self) can't be resolved. Register first.")
        }
        return resolved
    }
}
