import Foundation

#if canImport(AlicerceCore)
import AlicerceCore
#endif

extension Network {

    /// A base request making witness.
    struct BaseRequestMaking<Request> {

        /// A make base request handler closure, invoked when the request generation finishes.
        typealias RequestHandler = (Result<Request, Error>) -> Cancelable

        /// The make base request closure, invoked to generate a new base request.
        ///
        /// - Important: The cancelable returned by the `handler` closure *when called asynchronously* should be added
        /// as a child of the cancelable returned by this closure, so that the async work gets chained and can be
        /// cancelled.
        ///
        /// - Parameter handler: The closure to handle the request generation's result (i.e. either the new request or
        /// an error).
        /// - Returns: A cancelable to cancel the operation.
        let make: (_ handler: RequestHandler) -> Cancelable

        /// Instantiates a new base request maker, with the given make closure.
        /// - Parameter make: The make base request closure.
        init(make: @escaping (_ handler: RequestHandler) -> Cancelable) {

            self.make = make
        }
    }
}

extension Network.BaseRequestMaking where Request == URLRequest {

    /// Creates a new base request making witness from an `HTTPResourceEndpoint`.
    /// - Parameter endpoint: the endpoint to make the base request from.
    static func endpoint(_ endpoint: HTTPResourceEndpoint) -> Self {

        .init { handler in handler(Result { try endpoint.makeRequest() }) }
    }
}
