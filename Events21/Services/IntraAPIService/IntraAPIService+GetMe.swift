//
//  IntraAPIService+GetMe.swift
//  Events21
//
//  Created by out-nazarov2-ms on 09.10.2021.
//

import Foundation

extension IntraAPIService {
    func getMe(completion: @escaping (Result<UserFullModel, IntraAPIError>) -> Void) {
        urlComponents.path = "/v2/me"
		print("\(request.httpMethod ?? "GET") \(request.url?.absoluteString ?? "")")
        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
			if let error = error {
				completion(.failure(IntraAPIError(error: "Error", errorDescription: error.localizedDescription)))
				return
			}
			guard let data = data else {
				completion(.failure(IntraAPIError(error: "Error", errorDescription: "Unknown Error")))
				return
			}
			print(data.jsonString ?? "")
            do {
				if let error = try? JSONDecoder.intraIso8601Full.decode(IntraAPIError.self, from: data) {
                    completion(.failure(error))
                    return
                }
                let me = try JSONDecoder.intraIso8601Full.decode(UserFullModel.self, from: data)
                self?.me = me
                completion(.success(me))
            } catch let error {
                completion(.failure(IntraAPIError(error: "JSONDecoderError", errorDescription: error.localizedDescription)))
            }
        }.resume()
    }
}
