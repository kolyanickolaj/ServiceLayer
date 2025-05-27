import Foundation

protocol NetworkStack: AnyObject {

    associatedtype Resource
    associatedtype Remote
    associatedtype Response
    associatedtype FetchError: Error

    @discardableResult
    func fetch(resource: Resource, completion: @escaping FetchCompletionClosure) -> Cancelable
}

extension NetworkStack {

    typealias CompletionClosure<T, E: Error> = (Result<Network.Value<T, Response>, E>) -> Void
    typealias FetchCompletionClosure = CompletionClosure<Remote, FetchError>
    typealias FetchResult = Result<Network.Value<Remote, Response>, FetchError>

    @discardableResult
    func fetchAndDecode<Model>(
        resource: Resource,
        request: RequestResource,
        parser: ResponseParser<Model>,
        errorExtractor: ErrorExtracting,
        completion: @escaping CompletionClosure<Model, Error>
    ) -> Cancelable where Remote == Data, Response == URLResponse {
        fetch(resource: resource) { result in
            
            switch result {
            case .success(let value):
                do {
                    let model = try parser.parse(value.value)
                    completion(.success(Network.Value(value: model, response: value.response)))
                } catch let originalError {
                    if let error = errorExtractor.extract(request: request, error: originalError) {
                        completion(.failure(error))
                    } else {
                        completion(.failure(FetchAndDecodeError.decode(originalError)))
                    }
                }
            case .failure(let error):
                if let parsedError = errorExtractor.extract(request: request, error: error) {
                    completion(.failure(parsedError))
                } else {
                    completion(.failure(FetchAndDecodeError.fetch(error)))
                }
            }
        }
    }
}
