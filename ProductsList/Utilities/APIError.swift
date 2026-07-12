import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decoding(Error)
    case network(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "INVALID URL"
        case .invalidResponse:
            return "INVALID RESPONSE"
        case .decoding(let error):
            return "Decoding error \(error.localizedDescription)"
        case .network(let error):
            return "Network error \(error.localizedDescription)"
        }
    }
}
