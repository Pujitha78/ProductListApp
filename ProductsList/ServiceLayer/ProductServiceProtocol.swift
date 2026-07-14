import Foundation

protocol ProductServiceProtocol {
    func fetchDummyProducts(page: Int) async throws -> DummyProductResponse
    func fetchProducts() async throws -> [ProductsResponseModel]
}

