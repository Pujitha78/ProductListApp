//
//  ContentView.swift
//  ProductsList
//
//  Created by Pujitha Kadiyala on 6/29/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ProductsViewModel = ProductsViewModel()
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.loadingState {
                    ProgressView("Loading details")
                } else if viewModel.errorString != nil {
                    Text(viewModel.errorString ?? "error")
                } else {
                    List(viewModel.productsList) { product in
                        NavigationLink {
                            ProductDetailsView(product: product)
                        } label: {
                            ProductRowView(product: product)
                        }
                    }
                    .refreshable {
                        await viewModel.fetchProducts()
                    }
                }
            }
            .navigationTitle("Product List")
            .task {
                if viewModel.productsList.isEmpty {
                    await viewModel.fetchProducts()
                }
            }
        }
    }
}

struct ProductRowView: View {
    var product: ProductsResponseModel
    var body: some View {
        HStack {
            ProductImageView(urlString: product.image ?? "", imageKey: "\(product.id ?? 0)")
//            AsyncImage(url: URL(string: product.image ?? "")!) { image in
//                image
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 50, height: 50)
//            } placeholder: {
//                ProgressView()
//            }
            VStack(alignment: .leading, spacing: 6) {
                Text(product.title ?? "")
                    .font(.headline)
                    .lineLimit(2)
                
                Text("$\(product.price ?? 0.0, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
