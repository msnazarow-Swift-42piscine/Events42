//
//  IntraAPIService.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//


// TODO: Автопродление токена ( допилить получение токена, распарсить модель ошибки и в случае неё заново послать запрос, получить новый токен)
// TODO: разобраться как происходит авторизация ПОЛЬЗОВАТЕЛЯ(я так и не понял)

import Foundation

protocol IntraAPIServiceProtocol {
    func getRecentEvents(for userID: String, complition: @escaping (Result<[EventResponse], Error>) -> Void)
}

class IntraAPIService: IntraAPIServiceProtocol {
    let accessToken = "c70498426056d011b250dd12ba60099a2a299b64a6e75b447069dee2bf02a1bd"
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategyFormatters = [.iso8601Full]
        return decoder
    }()

    func getRecentEvents(for userID: String, complition: @escaping (Result<[EventResponse], Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.intra.42.fr"
        urlComponents.path = "/v2/events"
//        urlComponents.path = "/v2/users/sgertrud/events"
//        urlComponents.path = "/oauth/authorize?client_id=your_very_long_client_id&redirect_uri=http%3A%2F%2Flocalhost%3A1919%2Fusers%2Fauth%2Fft%2Fcallback&response_type=code&scope=public&state=a_very_long_random_string_witchmust_be_unguessable"
        urlComponents.queryItems = [
//            .init(name: "user_id", value: userID),
//            .init(name: "sort", value: "kind,location,remote"),
            .init(name: "range[begin_at]", value: "\(Date().iso8601Full),\(Calendar.current.date(byAdding: .year, value: 100, to: Date())!.iso8601Full)"),
//            .init(name: "cursus_id", value: "21"),
        ]
        var request = URLRequest(url: urlComponents.url!)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                complition(.failure(error))
                return
            }
            guard let data = data else {
                complition(.failure(error!))
                return
            }
            do {
                try print(JSONSerialization.jsonObject(with: data))
                let tweets = try self.decoder.decode([EventResponse].self, from: data)
                complition(.success(tweets))
            } catch {
                complition(.failure(error))
            }
        }.resume()
    }
}
