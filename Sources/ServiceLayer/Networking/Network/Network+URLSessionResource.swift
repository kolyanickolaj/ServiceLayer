import Foundation

#if canImport(AlicerceCore)
import AlicerceCore
#endif

extension Network {

    struct URLSessionResource {

        let baseRequestMaking: BaseRequestMaking<URLRequest>
        let interceptors: [URLSessionResourceInterceptor]
        var retryState: Retry.State
        let retryActionPriority: Retry.Action.CompareClosure

        init(
            baseRequestMaking: BaseRequestMaking<URLRequest>,
            interceptors: [URLSessionResourceInterceptor] = [],
            retryActionPriority: @escaping Retry.Action.CompareClosure = Retry.Action.mostPrioritary
        ) {

            self.baseRequestMaking = baseRequestMaking
            self.interceptors = interceptors
            self.retryState = .empty
            self.retryActionPriority = retryActionPriority
        }
    }
}

extension Network.URLSessionResource {

    typealias RequestHandler = (Result<URLRequest, Error>) -> Cancelable

    func makeRequest(handler: @escaping RequestHandler) -> Cancelable {

        baseRequestMaking.make { [interceptors] requestResult in

            var iterator = interceptors.makeIterator()

            guard let first = iterator.next() else { return handler(requestResult) }

            // chain interceptors recursively
            func makeHandler() -> RequestHandler {
                return { newResult -> Cancelable in
                    if let next = iterator.next() {
                        return next.interceptMakeRequestResult(newResult, handler: makeHandler())
                    }
                    return handler(newResult)
                }
            }

            return first.interceptMakeRequestResult(requestResult, handler: makeHandler())
        }
    }

    func interceptScheduledTask(withIdentifier taskIdentifier: Int, request: URLRequest) {

        interceptors.forEach {
            $0.interceptScheduledTask(withIdentifier: taskIdentifier, request: request, retryState: retryState)
        }
    }

    func interceptSuccessfulTask(
        withIdentifier taskIdentifier: Int,
        request: URLRequest,
        data: Data,
        response: URLResponse
    ) {

        interceptors.forEach {
            $0.interceptSuccessfulTask(
                withIdentifier: taskIdentifier,
                request: request,
                data: data,
                response: response,
                retryState: retryState
            )
        }
    }

    func interceptFailedTask(
        withIdentifier taskIdentifier: Int,
        request: URLRequest,
        data: Data?,
        response: URLResponse?,
        error: Network.URLSessionError
    ) -> Retry.Action {

        interceptors
            .lazy
            .map {
                $0.interceptFailedTask(
                    withIdentifier: taskIdentifier,
                    request: request,
                    data: data,
                    response: response,
                    error: error,
                    retryState: self.retryState
                )
            }
            .reduce(Retry.Action.none, retryActionPriority)
    }
}
