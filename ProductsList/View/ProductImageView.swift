//
//  ProductImageView.swift
//  ProductsList
//
//  Created by Pujitha Kadiyala on 7/12/26.
//

import SwiftUI

struct ProductImageView: View {
    @StateObject var viewModel: ImageLoadViewModel
    
    init(urlString: String, imageKey: String) {
        _viewModel = StateObject(wrappedValue: ImageLoadViewModel(urlString: urlString, imageKey: imageKey))
    }
   
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            }
        }
    }
}

#Preview {
    ProductImageView(urlString: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png", imageKey: "1")
}
