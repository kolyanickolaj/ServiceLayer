//
//  BaseRequest.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 27.05.25.
//
import Foundation

public protocol BaseRequest: RequestResource {
    var zone: RequestZone { get }
    var method: HTTP.Method { get }
    var baseURL: URL { get }
    var path: String { get }
    var apiVersion: ApiVersion { get }
    var apiLevel: String { get }
    var queryItems: [URLQueryItem]? { get }
    var headers: HTTP.Headers? { get }
    
    func makeBody() throws -> Data?
}

extension BaseRequest {
    public var zone: RequestZone {
        .public
    }
    
    public var method: HTTP.Method {
        .GET
    }

    public var path: String {
        ""
    }
    
    public var apiVersion: ApiVersion {
        .v3
    }
    
    public var queryItems: [URLQueryItem]? {
        nil
    }

    public var headers: HTTP.Headers? {
        defaultHeaders
    }
    
    var defaultHeaders: HTTP.Headers {
        [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }
    
    public func makeBody() throws -> Data? {
        nil
    }
    
    public var apiLevel: String {
        switch apiVersion {
        case .api: return "api"
        case .v1: return "api/v1"
        case .v2: return "api/v2"
        case .v3: return "api/v3"
        }
    }

    public var baseURL: URL {
        ServiceLayer.constants.platformHost
    }
}

public enum ApiVersion: String {
    case v1, v2, v3, api
}
