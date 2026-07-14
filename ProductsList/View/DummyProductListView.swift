import SwiftUI

struct DummyProductListView: View {
    @StateObject private var viewModel = ProductViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.products) { product in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(product.title)
                            .font(.headline)
                        
                        Text("$\(product.price, specifier: "%.2f")")
                            .foregroundColor(.blue)
                    }
                    .onAppear {
                        if let index = viewModel.products.firstIndex(where: { $0.id == product.id }),
                           index == viewModel.products.count - 5 {
                            Task {
                                await viewModel.fetchProducts()
                            }
                        }
                    }
                }
                
                if viewModel.isLoading {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
            }
            .navigationTitle("Products")
            .task {
                await viewModel.fetchProducts()
            }
            .refreshable {
                await viewModel.refresh()
            }
        }
    }
}
#Preview {
    DummyProductListView()
}
