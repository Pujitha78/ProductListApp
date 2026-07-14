import Foundation

final class ProductService: ProductServiceProtocol {
    private let networkManager = NetworkManager()

    func fetchDummyProducts(page: Int) async throws -> DummyProductResponse {
        let limit = APIConstants.pageLimit
        let skip = (page - 1) * APIConstants.pageLimit
        
        guard var components = URLComponents(
            string: APIConstants.BaseURL.dummy + APIConstants.Path.products
        ) else { throw APIError.invalidURL }

        components.queryItems = [
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "skip", value: "\(skip)")
        ]

        guard let url = components.url else {
            throw APIError.invalidURL
        }

        return try await networkManager.fetch(
            from: url.absoluteString,
            type: DummyProductResponse.self
        )
    }
    
    func fetchProducts() async throws -> [ProductsResponseModel] {
        return try await networkManager.fetch(
            from: "\(APIConstants.BaseURL.fakeStore)/products",
            type: [ProductsResponseModel].self
        )
    }
}
