import Foundation

struct DummyProductResponse: Codable {
    let products: [DummyProduct]
    let total: Int
    let skip: Int
    let limit: Int
}

struct DummyProduct: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let thumbnail: String
}
