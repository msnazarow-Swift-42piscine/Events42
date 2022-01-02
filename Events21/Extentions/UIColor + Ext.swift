//
//  UIColor + Ext.swift
//  Events21
//
//  Created by 19733654 on 02.01.2022.
//

import UIKit

extension UIColor {
	func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
		return UIGraphicsImageRenderer(size: size).image { rendererContext in
			self.setFill()
			rendererContext.fill(CGRect(origin: .zero, size: size))
		}
	}
}
