import Foundation

public enum FetchAndDecodeError: Error, LocalizedError {
    case fetch(Error)
    case decode(Error)
    
    public var errorDescription: String? {
        switch self {
        case .fetch(let error):
            return error.localizedDescription
        case .decode(let error):
            return error.localizedDescription
        }
    }
}
