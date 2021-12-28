//
//  UIimage+Ext.swift
//  Events21
//
//  Created by 19733654 on 28.12.2021.
//

import UIKit

extension UIImage {
	func resizedImage(newHeight: CGFloat) -> UIImage? {
		let scale = newHeight / size.height
		let newWidth = size.width * scale
		UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
		draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return newImage
	}
}
