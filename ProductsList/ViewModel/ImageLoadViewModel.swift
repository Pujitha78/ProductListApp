import Foundation
import SwiftUI
import Combine

final class ImageLoadViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
    
    private let manager = ImageCacheManager.shared
    private let urlString: String
    private let imageKey: String
    
    init(urlString: String, imageKey: String) {
        self.urlString = urlString
        self.imageKey = imageKey
        Task {
            try await loadImage()
        }
    }
    
    func loadImage() async throws{
        if let cached = manager.get(key: imageKey){
            image = cached
            return
        }
        isLoading = true
        defer { isLoading = false }
        do {
            guard let url = URL(string: urlString) else { throw APIError.invalidURL}
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else { throw APIError.invalidResponse }
            if let downloaded = UIImage(data: data) {
                manager.store(downloaded, for: imageKey)
                image = downloaded
            }
        } catch {
            throw APIError.decoding(error)
        }
    }
}
