//
//  IntraAPIService+GetEvents.swift
//  Events21
//
//  Created by out-nazarov2-ms on 09.10.2021.
//

import Foundation

extension IntraAPIService {

    func getFutureEvents(campusId: Int? = nil,
                         cursusId: Int? = nil,
                         sort: [String], filter: [String: [String]],
                         completion: @escaping (Result<[EventResponse], IntraAPIError>) -> Void) {
        var filter = filter
        filter["future"] = ["true"]
        getEvents(campusId: campusId ?? me.campus.last?.id,
                  cursusId: cursusId ?? me.cursusUsers.last?.cursusId,
                  sort: sort,
                  filter: filter,
                  completion: completion)
    }

    func getEvents(campusId: Int? = nil,
                   cursusId: Int? = nil,
                   sort: [String],
                   filter: [String: [String]],
                   completion: @escaping (Result<[EventResponse], IntraAPIError>) -> Void){
        urlComponents.path = "/v2"
        if let campusId = campusId {
            urlComponents.path.append("/campus/\(campusId)")
        }
        if let cursusId = cursusId {
            urlComponents.path.append("/cursus/\(cursusId)")
        }
        urlComponents.path.append("/events")
        var queryItems: [URLQueryItem] = []
        if !sort.isEmpty {
            queryItems.append(.init(name: "sort", value: sort.joined(separator: ",")))
        }
        if !filter.isEmpty {
            filter.forEach { (key: String, value: [String]) in
                queryItems.append(.init(name: "filter[\(key)]", value: value.joined(separator: ",")))
            }
        }
//        queryItems.append(.init(name: "range[begin_at]", value: "\(Date().iso8601Full),\(Calendar.current.date(byAdding: .year, value: 100, to: Date())!.iso8601Full)"))
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

    func getUserEvents(completion: @escaping (Result<[EventUsersResponse], IntraAPIError>) -> Void) {
        urlComponents.path = "/v2/users/\(me.id)/events_users"
//        urlComponents.queryItems = [
//            .init(name: "user_id", value: "\(me.id)"),
//            .init(name: "sort", value: "kind,location,remote"),
//            .init(name: "range[begin_at]", value: "\(Date().iso8601Full),\(Calendar.current.date(byAdding: .year, value: 100, to: Date())!.iso8601Full)"),
            //            .init(name: "cursus_id", value: "21"),
//        ]
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
                let events = try self.decoder.decode([EventUsersResponse].self, from: data)
                completion(.success(events))
            } catch {
                completion(.failure(IntraAPIError(error: "JSONDecoder error", errorDescription: error.localizedDescription)))
            }
        }.resume()
    }

    func registerToEvent(eventId: Int, completion: @escaping (Result<Bool, IntraAPIError>) -> Void) {
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
                try self.decoder.decode(EventRegisterResponse.self, from: data)
                completion(.success(true))
            } catch {
                completion(.failure(IntraAPIError(error: "JSONDecoder error", message: error.localizedDescription)))
            }
        }.resume()
    }
}
