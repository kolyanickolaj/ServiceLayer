import Foundation

public typealias RequestResource = HTTPResourceEndpoint

public enum RequestZone {
    case `public`, `private`, privateCms
}

/// A type representing an HTTP resource's endpoint, to generate its request.
///
/// Especially useful when conformed to by an enum, allowing a type safe modelling of an API's endpoints.
public protocol HTTPResourceEndpoint {

    var zone: RequestZone { get }
        
    /// The HTTP method.
    var method: HTTP.Method { get }

    /// The base URL.
    var baseURL: URL { get }

    /// The URL's path subcomponent.
    var path: String { get }
        
    /// The Api Version.
    var apiLevel: String { get }

    /// The URL's query string items.
    var queryItems: [URLQueryItem]? { get }

    /// The HTTP header fields.
    var headers: HTTP.Headers? { get }
        
    // Makes the HTTP message body data.
    func makeBody() throws -> Data?

    // Makes the URL request.
    func makeRequest() throws -> URLRequest
}

extension HTTPResourceEndpoint {
    var path: String { "" }
    var queryItems: [URLQueryItem]? { nil }
    var headers: HTTP.Headers? { nil }
    
    public func makeBody() throws -> Data? { nil }

    public func makeRequest() throws -> URLRequest {

        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            assertionFailure("😱 Failed to create components from URL: \(baseURL) on \(type(of: self))!")
            return URLRequest(url: baseURL)
        }

        if let queryItems = queryItems {
            components.queryItems = (components.queryItems ?? []) + queryItems
        }
        
        print("__--path = \(path)")
        if !path.isEmpty {
            let pullPath = NSString.path(withComponents: ["/" + apiLevel + "/" + path])
            components.path = components.path.appending(pullPath).replacingOccurrences(of: "//", with: "/")
        }

        guard let url = components.url else {
            assertionFailure("😱 Failed to extract URL from components: \(components) on \(type(of: self))!")
            return URLRequest(url: baseURL)
        }

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpBody = try makeBody()

        return urlRequest
    }
}
