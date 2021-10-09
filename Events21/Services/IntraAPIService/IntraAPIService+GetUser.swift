//
//  IntraAPIService+GetUser.swift
//  Events21
//
//  Created by out-nazarov2-ms on 09.10.2021.
//

import Foundation

extension IntraAPIService {
    func getMe(completion: @escaping (Result<MeResponse, IntraAPIError>) -> Void) {
        urlComponents.path = "/v2/me"
        URLSession.shared.dataTask(with: request){ data, _, error in
            guard let data = data, error == nil else { return }
            do {
                if let error = try? self.decoder.decode(IntraAPIError.self, from: data) {
                    completion(.failure(error))
                    return
                }
//                try print(JSONSerialization.jsonObject(with: data, options: []))
                let me = try self.decoder.decode(MeResponse.self, from: data)
                self.me = me
                completion(.success(me))
            } catch {
                completion(.failure(IntraAPIError(error: "JSONDecoderError", errorDescription: error.localizedDescription)))
            }
        }.resume()
    }
}
