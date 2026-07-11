import Foundation

final class MockService: ProductServiceProtocol {

    var shouldThrowError = false

    func fetchProducts() async throws -> [ProductsResponseModel] {

        if shouldThrowError {
            throw APIError.invalidResponse
        }

        return [
            ProductsResponseModel(
                id: 1,
                title: "iPhone",
                price: 999,
                description: "Apple Phone",
                category: "Electronics",
                image: "",
                rating: Rating(rate: 9.8, count: 10)
            )
        ]
    }
}
