import SwiftUI
import Foundation

final class ImageCacheManager {
    static let shared = ImageCacheManager()
    private init() {}

    private let cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 200 * 1024 * 1024 // 200 MB
        return cache
    }()

    func get(key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

    func store(_ image: UIImage, for key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
