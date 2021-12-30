//
//  UserMainInteractor.swift
//  Events21
//
//  Created by 19733654 on 27.12.2021.
//  
//

import UIKit

class UserMainInteractor: PresenterToInteractorUserMainProtocol {

	let intraAPIService: IntraAPIServiceProtocol
	let imageCashingService: ImageCashingServiceProtocol

	init(
		intraAPIService: IntraAPIServiceProtocol,
		imageCashingService: ImageCashingServiceProtocol
	) {
		self.intraAPIService = intraAPIService
		self.imageCashingService = imageCashingService
	}

	func getImage(for url: URL, completion: @escaping (UIImage?) -> Void) {
		imageCashingService.getImage(for: url, comletion: completion)
	}

	func removeToken(){
		intraAPIService.removeCode()
		intraAPIService.removeToken()
	}
}
