//
//  IntraAPIService+PostDeleteEvents.swift
//  Events21
//
//  Created by out-nazarov2-ms on 12.10.2021.
//

import Foundation

extension IntraAPIService {
    func registerToEvent(eventId: Int, completion: @escaping (Result<EventUsersResponse, IntraAPIError>) -> Void) {
        urlComponents.path = "/v2/events_users"
        urlComponents.queryItems = [
            .init(name: "events_user[event_id]", value: "\(eventId)"),
            .init(name: "events_user[user_id]", value: "\(me!.id)")
        ]
        var request = self.request
        request.httpMethod = "POST"
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(IntraAPIError(error: "URLSessionError", errorDescription: error.localizedDescription)))
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(.failure(IntraAPIError(error: "URLSessionError")))
                return
            }
            do {
                if let error = try? self.decoder.decode(IntraAPIError.self, from: data) {
                    completion(.failure(error))
                    return
                }
//                try print(JSONSerialization.jsonObject(with: data, options: []))
                let event = try self.decoder.decode(EventUsersResponse.self, from: data)
                completion(.success(event))
            } catch {
                completion(.failure(IntraAPIError(error: "JSONDecoder error", message: error.localizedDescription)))
            }
        }.resume()
    }

    func unregisterFromEvent(eventUserId: Int, completion: @escaping (Result<Bool, IntraAPIError>) -> Void) {
        urlComponents.path = "/v2/events_users/\(eventUserId)"
        var request = self.request
        request.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(IntraAPIError(error: "URLSessionError", errorDescription: error.localizedDescription)))
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(.failure(IntraAPIError(error: "URLSessionError")))
                return
            }
            do {
                if let error = try? self.decoder.decode(IntraAPIError.self, from: data) {
                    completion(.failure(error))
                    return
                }
                if String(data: data, encoding: .utf8) == "{}" {
                    completion(.failure(IntraAPIError(error: "No data")))
                    return
                }
//                try self.decoder.decode(EventRegisterResponse.self, from: data)
                completion(.success(true))
            } catch {
                completion(.failure(IntraAPIError(error: "JSONDecoder error", message: error.localizedDescription)))
            }
        }.resume()
    }
}
