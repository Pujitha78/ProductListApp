import Foundation
import SwiftUI
import Combine

class ProductsViewModel: ObservableObject {
    @Published var productsList: [ProductsResponseModel] = []
    @Published var loadingState = false
    @Published var errorString: String?
    
    private let service: ProductServiceProtocol
    
    init(service: ProductServiceProtocol = ProductService()) {
        self.service = service
    }
    
    func fetchProducts() async {
        loadingState = true
        errorString = nil
        
        defer {
            loadingState = false
        }
        
        do {
            productsList = try await service.fetchProducts()
        } catch {
            errorString = error.localizedDescription
        }
    }
}

