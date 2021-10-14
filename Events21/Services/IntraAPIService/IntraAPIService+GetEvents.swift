//
//  IntraAPIService+GetEvents.swift
//  Events21
//
//  Created by out-nazarov2-ms on 09.10.2021.
//

import Foundation

extension IntraAPIService {
    func getEvents(campusId: Int? = nil,
                   cursusId: Int? = nil,
                   userId: Int? = nil,
                   sort: [String] = [],
                   filter: [String: [String]] = [:],
                   completion: @escaping (Result<[EventResponse], IntraAPIError>) -> Void) {
        urlComponents.path = "/v2/events"
        var queryItems: [URLQueryItem] = []
        if let campusId = campusId {
            queryItems.append(.init(name: .campusId, value: "\(campusId)"))
        }

        if let cursusId = cursusId {
            queryItems.append(.init(name: .cursusId, value: "\(cursusId)"))
        }

        if let userId = userId {
            queryItems.append(.init(name: .userId, value: "\(userId)"))
        }

        if !sort.isEmpty {
            queryItems.append(.init(name: "sort", value: sort.joined(separator: ",")))
        }

        if !filter.isEmpty {
            filter.forEach { (key: String, value: [String]) in
                queryItems.append(.init(name: "filter[\(key)]", value: value.joined(separator: ",")))
            }
        }
        queryItems.append(.init(name: "page[size]", value: "100"))
        urlComponents.queryItems = queryItems
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(IntraAPIError(error: "URLSessionError", errorDescription: error.localizedDescription)))
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(.failure(IntraAPIError(error: "URLSessionError")))
                return
            }
            if response.statusCode >= 400 {
                completion(.failure(IntraAPIError(error: response.value(forHTTPHeaderField: "Status") ?? "HTTP Error", errorDescription: data.html2String, statusCode: response.statusCode)))
                return
            }
            do {
                if let error = try? self.decoder.decode(IntraAPIError.self, from: data) {
                    completion(.failure(error))
                    return
                }
//                try print(JSONSerialization.jsonObject(with: data, options: []))
                let events = try self.decoder.decode([EventResponse].self, from: data)
                completion(.success(events))
            } catch {
                completion(.failure(IntraAPIError(error: "JSONDecoder error", errorDescription: error.localizedDescription)))
            }
        }.resume()
    }

    func getUserEvents(userId: Int?, eventId: Int?, sort: [String], filter: [String : [String]], completion: @escaping (Result<[EventUsersResponse], IntraAPIError>) -> Void) {
        urlComponents.path = ("/v2/events_users")
        var queryItems: [URLQueryItem] = []
        if let eventId = eventId {
            queryItems.append(.init(name: .eventId, value: "\(eventId)"))
        }

        if let userId = userId {
            queryItems.append(.init(name: .userId, value: "\(userId)"))
        }

        if !sort.isEmpty {
            queryItems.append(.init(name: "sort", value: sort.joined(separator: ",")))
        }

        if !filter.isEmpty {
            filter.forEach { (key: String, value: [String]) in
                queryItems.append(.init(name: "filter[\(key)]", value: value.joined(separator: ",")))
            }
        }
        queryItems.append(.init(name: "page[size]", value: "100"))
        urlComponents.queryItems = queryItems

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
//                if String(data: data, encoding: .utf8) == "{}" {
//                    co
//                }
//                try print(JSONSerialization.jsonObject(with: data, options: []))
                let events = try self.decoder.decode([EventUsersResponse].self, from: data)
                completion(.success(events))
            } catch {
                completion(.failure(IntraAPIError(error: "JSONDecoder error", errorDescription: error.localizedDescription)))
            }
        }.resume()
    }
}
