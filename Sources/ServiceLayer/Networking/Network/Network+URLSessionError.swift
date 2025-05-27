import Foundation

#if canImport(AlicerceCore)
import AlicerceCore
#endif

extension Network {

    public enum URLSessionError: Error {

        typealias TotalRetriedDelay = Retry.Delay

        case noRequest(Error)
        case server(HTTP.StatusCode, Data?, URLResponse)
        case noData(HTTP.StatusCode, URLResponse)
        case url(URLError)
        case badResponse(URLResponse?)
        case retry(Retry.Error, Retry.State)
        case cancelled
    }
}

extension Network.URLSessionError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .noRequest(let error):
            return error.localizedDescription
        case .server(_, let aPIError, _):
            return nil
        case .noData(_, _):
            return nil
        case .url(let uRLError):
            return uRLError.localizedDescription
        case .badResponse(_):
            return nil
        case .retry(let error, _):
            return error.localizedDescription
        case .cancelled:
            return nil
        }
    }
}

extension Network.URLSessionError {

    var error: Error? {
        switch self {
        case .noRequest,
             .noData,
             .badResponse,
             .cancelled:
            return self
        case .url(let nserror):
            return nserror
        case .server(_, let error, _):
            return nil

        case .retry(_, let state):
            return state.errors.last as? Network.URLSessionError ?? self
        }
    }
    
    var response: URLResponse? {

        switch self {
        case .noRequest,
             .url,
             .cancelled:
            return nil

        case .server(_, _, let response),
             .noData(_, let response):
            return response

        case .badResponse(let response):
            return response

        case .retry(_, let state):
            return (state.errors.last as? Network.URLSessionError)?.response
        }
    }

    var lastError: Network.URLSessionError {

        switch self {
        case .noRequest,
             .server,
             .noData,
             .url,
             .badResponse,
             .cancelled:
            return self

        case .retry(_, let state):
            return state.errors.last as? Network.URLSessionError ?? self
        }
    }

    var statusCode: HTTP.StatusCode? {

        switch self {
        case .server(let statusCode, _, _),
             .noData(let statusCode, _):
            return statusCode

        case .noRequest,
             .badResponse,
             .cancelled:
            return nil
        case .url(let urlError):
            return .unknownError(urlError.errorCode)

        case .retry(_, let state):
            return (state.errors.last as? Network.URLSessionError)?.statusCode
        }
    }
}
