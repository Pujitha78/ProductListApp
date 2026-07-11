//
//  ProductDetails.swift
//  ProductsList
//
//  Created by Pujitha Kadiyala on 6/29/26.
//

import SwiftUI

struct ProductDetailsView: View {
    var product: ProductsResponseModel
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                AsyncImage(url: URL(string: product.image ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 250)
                
                Text(product.title ?? "")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("$\(product.price ?? 0.0, specifier: "%.2f")")
                    .font(.title3)
                    .foregroundColor(.blue)
                
                Text("Category")
                    .font(.headline)
                
                Text(product.category ?? "")
                    .foregroundColor(.secondary)
                
                Text("Description")
                    .font(.headline)
                
                Text(product.description ?? "")
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .navigationTitle("Product Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ZStack {
        ProductDetailsView(product: ProductsResponseModel(id: 3, title: "title", price: 10000, description: "product details", category: "cat", image: "ghjkvbn", rating: Rating(rate: 10000, count: 2)))
    }
}
