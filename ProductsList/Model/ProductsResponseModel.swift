import Foundation

struct ProductsResponseModel: Decodable, Identifiable {
//    image,name,price
    let id: Int?
    let title: String?
    let price: Double?
    let description: String?
    let category: String?
    let image: String?
    let rating: Rating?
}

struct Rating: Decodable {
    let rate: Float?
    let count: Int?
}
