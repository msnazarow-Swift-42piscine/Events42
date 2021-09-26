//
//  ImageCashingService.swift
//  MiniTwitter
//
//  Created by out-nazarov2-ms on 25.09.2021.
//

import Foundation
import UIKit

protocol ImageCashingServiceProtocol {
    func getImage(for urlString: String, comlition: @escaping (UIImage?) -> Void)
    func saveImage(for url: String, image: UIImage)
}

class ImageCashingService: ImageCashingServiceProtocol {
    var images: [String: UIImage] = [:]
    func getImage(for urlString: String, comlition: @escaping (UIImage?) -> Void) {
        if let image = images[urlString] {
            comlition(image)
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
                    comlition(image)
                }
            }.resume()
        }
    }

    func saveImage(for url: String, image: UIImage) {
        images[url] = image
    }
}
