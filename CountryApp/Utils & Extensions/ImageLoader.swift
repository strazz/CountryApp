//
//  ImageLoader.swift
//  CountryApp
//
//  Created by Giovanni Romaniello on 02/01/22.
//

import Foundation
import Combine
import SwiftUI

class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSURL, UIImage>()
    private let apiClient = APIClient()
    private init() { }
    
    func image(for url: URL?) -> AnyPublisher<UIImage?, ImageCacheError> {
        guard let url = url else {
            return Fail(error: ImageCacheError.invalidUrl)
                .eraseToAnyPublisher()
        }
        guard let image = cache.object(forKey: url as NSURL) else {
            return Just(url)
                .asyncMap { [weak self] url in
                    let response = try await self?.apiClient.run(URLRequest(url: url))
                    guard let data = response?.value else {
                        throw ImageCacheError.dataConversionFailed
                    }
                    guard let image = UIImage(data: data) else {
                        throw ImageCacheError.dataConversionFailed
                    }
                    self?.cache.setObject(image, forKey: url as NSURL)
                    return image
                }
                .mapError({ error in ImageCacheError.sessionError(error) })
                .eraseToAnyPublisher()
        }
        return Just(image)
            .mapError({ error in ImageCacheError.sessionError(error) })
            .eraseToAnyPublisher()
    }
}

class ImageModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    var cacheSubscription: AnyCancellable?
    init(url: URL?) {
        isLoading = true
        cacheSubscription = ImageCache.shared
            .image(for: url)
            .replaceError(with: nil)
            .receive(on: RunLoop.main, options: .none)
            .sink(receiveValue: { [weak self] result in
                self?.isLoading = false
                self?.image = result
            })
    }
}
