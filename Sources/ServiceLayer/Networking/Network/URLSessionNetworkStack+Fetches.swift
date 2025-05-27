//
//  URLSessionNetworkStack+fetches.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 8/7/23.
//

import Foundation

extension Network.URLSessionNetworkStack {
    
    func fetch<Request: ModelRequest, Model>(
        request: Request,
        interceptors: [URLSessionResourceInterceptor],
        completion: @escaping (Result<Model, Error>) -> Void
    ) where Model == Request.Model {
        let modelParser = ModelRequestJSONParser(request: request)
        let parser = ResponseParser(parser: modelParser)

        return fetch(
            request: request,
            interceptors: interceptors,
            parser: parser,
            completion: completion
        )
    }
    
    func fetchList<Request: ModelRequest, Model>(
        request: Request,
        interceptors: [URLSessionResourceInterceptor],
        completion: @escaping (Result<[Model], Error>) -> Void
    ) where Model == Request.Model {
        let modelParser = ModelRequestArrayParser(request: request)
        let parser = ResponseParser(parser: modelParser)

        return fetch(
            request: request,
            interceptors: interceptors,
            parser: parser,
            completion: completion
        )
    }
    
    private func fetch<Request: ModelRequest, Model>(
        request: Request,
        interceptors: [URLSessionResourceInterceptor],
        parser: ResponseParser<Model>,
        completion: @escaping (Result<Model, Error>) -> Void) {
            let r: Resource = .init(
                baseRequestMaking: .endpoint(request),
                interceptors: interceptors
            )
            
            fetchAndDecode(
                resource: r,
                request: request,
                parser: parser,
                errorExtractor: errorExctracting
            ) { r in
                switch r {
                case .success(let result):
                    completion(.success(result.value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
}
