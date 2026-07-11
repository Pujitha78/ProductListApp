import Foundation

protocol ProductServiceProtocol {
    func fetchProducts() async throws  -> [ProductsResponseModel]
}

final class ProductService: ProductServiceProtocol {
    private let networkManger = NetworkManager()
    
    func fetchProducts() async throws -> [ProductsResponseModel] {
         try await networkManger.fetch(
            from: EndPointURL.baseURL,
            type: [ProductsResponseModel].self)
    }
}
