//
//  IntraAPIService+GetUsers.swift
//  Events21
//
//  Created by 19733654 on 28.12.2021.
//

import Foundation

extension IntraAPIService {
	func getUsers(userId: Int?, eventId: Int?, sort: [String], filter: [String : [String]], completion: @escaping (Result<[EventUsersResponse], IntraAPIError>) -> Void) {
		urlComponents.path = ("/v2/users")
		var queryItems: [URLQueryItem?] = [
			eventId?.URLQueryItem(name: .eventId),
			userId?.URLQueryItem(name: .userId),
			sort.URLQueryItem(name: "sort"),
			100.URLQueryItem(name: "page[size]")
		] + filter.URLQueryItems(name: "filter")
		urlComponents.queryItems = queryItems.compactMap{ $0 }
		print("\(request.httpMethod ?? "GET") \(request.url?.absoluteString ?? "")")
		URLSession.shared.dataTask(with: request) { data, response, error in

			if let error = error {
				completion(.failure(IntraAPIError(error: "URLSessionError", errorDescription: error.localizedDescription)))
				return
			}
			guard let data = data, let response = response as? HTTPURLResponse else {
				completion(.failure(IntraAPIError(error: "URLSessionError")))
				return
			}
			print(data.jsonString ?? "")
			if response.statusCode >= 400 {
				completion(.failure(IntraAPIError(error: response.value(forHTTPHeaderField: "Status") ?? "HTTP Error", errorDescription: data.html2String, statusCode: response.statusCode)))
				return
			}
			do {
				if let error = try? JSONDecoder.intraIso8601Full.decode(IntraAPIError.self, from: data) {
					completion(.failure(error))
					return
				}

				let events = try JSONDecoder.intraIso8601Full.decode([EventUsersResponse].self, from: data)
				completion(.success(events))
			} catch {
				completion(.failure(IntraAPIError(error: "JSONDecoder error", errorDescription: error.localizedDescription)))
			}
		}.resume()
	}
}

private extension String {
	func URLQueryItem(name: String) -> URLQueryItem {
		.init(name: name, value: self)
	}
}

private extension Int {
	func URLQueryItem(name: String) -> URLQueryItem {
		.init(name: name, value: "\(self)")
	}
}

private extension Array where Element == String {
	func URLQueryItem(name: String) -> URLQueryItem? {
		if !self.isEmpty {
			return .init(name: "sort", value: self.joined(separator: ","))
		} else {
			return nil
		}
	}
}

private extension Dictionary where Key == String, Value == [String] {
	func URLQueryItems(name: String) -> [URLQueryItem] {
		if !self.isEmpty {
			return self.map { (key, value) -> URLQueryItem in
				.init(name: "\(name)[\(key)]", value: value.joined(separator: ","))
			}
		} else {
			return []
		}
	}
}
