import Foundation
import Combine

@MainActor
final class ProductViewModel: ObservableObject {
    @Published var products: [DummyProduct] = []
    @Published var isLoading = false
    private let service: ProductServiceProtocol
    private var currentPage = 1
    private var hasMoreData = true

    init(service: ProductServiceProtocol = ProductService()) {
        self.service = service
    }

    func fetchProducts() async {
        guard !isLoading, hasMoreData else { return }
        isLoading = true
        do {
            let response = try await service.fetchDummyProducts(page: currentPage)
            products.append(contentsOf: response.products)
            currentPage += 1
            hasMoreData = response.products.count == APIConstants.pageLimit
        } catch {
            print(error.localizedDescription)
        }
        isLoading = false
    }

    func refresh() async {
        currentPage = 1
        hasMoreData = true
        products.removeAll()
        await fetchProducts()
    }
}
