//
//  ImageCashingService.swift
//  MiniTwitter
//
//  Created by out-nazarov2-ms on 25.09.2021.
//

import Foundation
import UIKit

class ImageCashingService: ImageCashingServiceProtocol {
    var images: [String: UIImage] = [:]
    func getImage(for urlString: String, comletion: @escaping (UIImage?) -> Void) {
        if let image = images[urlString] {
            comletion(image)
        } else {
            var url = URL(string: urlString.replacingOccurrences(of: "_normal", with: ""))
            if url == nil {
                url = URL(string: urlString)
                if url == nil {
                    return
                }
            }
            URLSession.shared.dataTask(with: url!) { [self] data, _, _ in
                guard let data = data else {
                    return
                }
                if let image = UIImage(data: data) {
                    saveImage(for: urlString, image: image)
                    comletion(image)
                }
            }.resume()
        }
    }

    func saveImage(for url: String, image: UIImage) {
        images[url] = image
    }
}
