import Foundation

#if canImport(AlicerceCore)
import AlicerceCore
#endif

public enum Network {

    public struct Value<T, Response> {

        public let value: T
        public let response: Response
    }

    typealias URLSessionRetryPolicy = Retry.Policy<(URLRequest, Data?, URLResponse?)>
}

extension Network.Value {

    func mapValue<U>(_ f: (T, Response) throws -> U) rethrows -> Network.Value<U, Response> {

        .init(value: try f(value, response), response: response)
    }
}
