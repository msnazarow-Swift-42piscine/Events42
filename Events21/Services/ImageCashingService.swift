//
//  ImageCashingService.swift
//  MiniTwitter
//
//  Created by out-nazarov2-ms on 25.09.2021.
//

import Foundation
import UIKit

class ImageCashingService: ImageCashingServiceProtocol {
    var images: [URL: UIImage] = [:]
    func getImage(for url: URL, comletion: @escaping (UIImage?) -> Void) {
        if let image = images[url] {
            comletion(image)
        } else {
            URLSession.shared.dataTask(with: url) { [self] data, _, _ in
                guard let data = data else {
                    return
                }
                if let image = UIImage(data: data) {
                    saveImage(for: url, image: image)
                    comletion(image)
                }
            }.resume()
        }
    }

    func saveImage(for url: URL, image: UIImage) {
        images[url] = image
    }

	static let shared = ImageCashingService()

	private init() {}
}
