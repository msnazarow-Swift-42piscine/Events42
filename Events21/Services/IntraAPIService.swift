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
    func getRecentEvents(with userID: String, complition: @escaping (Result<[EventResponse], Error>) -> Void)
    func getMe(with token: String, comlition: @escaping (MeResponse) -> Void)
    func getToken(with code: String, complition: @escaping (String) -> Void)
}

class IntraAPIService: IntraAPIServiceProtocol {
    let redirecdedUrl = "events21://events21"//.addingPercentEncoding(withAllowedCharacters: .urlUserAllowed)!
    let uid = "304465722129fb447b62e46570c95cbad281250121c76f71a64fd9b0098baaa9"
    let secret = "9dd7cc32e3dd76eccfcd4587cd3a435ac3826d35c86715c92207aa8b868f06d1"
    var accessToken = "c70498426056d011b250dd12ba60099a2a299b64a6e75b447069dee2bf02a1bd"
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategyFormatters = [.iso8601Full]
        return decoder
    }()

    static let shared = IntraAPIService()
    private init(){}

    func getRecentEvents(with token: String, complition: @escaping (Result<[EventResponse], Error>) -> Void) {
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
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
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
//                try print(JSONSerialization.jsonObject(with: data))
                let tweets = try self.decoder.decode([EventResponse].self, from: data)
                complition(.success(tweets))
            } catch {
                complition(.failure(error))
            }
        }.resume()
    }

    func getMe(with token: String, comlition: @escaping (MeResponse) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.intra.42.fr"
        urlComponents.path = "/v2/me"
        var request = URLRequest(url: urlComponents.url!)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request){ data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let me = try self.decoder.decode(MeResponse.self, from: data)
                comlition(me)
            } catch {

            }
        }.resume()
    }

    func getToken(with code: String, complition: @escaping (String) -> Void) {

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.intra.42.fr"
        urlComponents.path = "/oauth/token"
        urlComponents.queryItems = [
            .init(name: "grant_type", value: "authorization_code"),
            .init(name: "client_id", value: uid),
            .init(name: "client_secret", value:secret),
            .init(name: "code", value: code),
            .init(name: "redirect_uri", value: redirecdedUrl)
        ]
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil {
//                self.delegate?.apiError(error: err, message: "1 - An error occurred for getToken")
            }
            else if let data = data {
                do {
                    let token = try self.decoder.decode(TokenResponse.self, from: data)
                    self.accessToken = token.accessToken
                    complition(token.accessToken)
                }
                catch ( _) {
//                    self.delegate?.apiError(error: err, message: "2 - An error occurred for getToken")
                }
            }
        }
        task.resume()
    }

    func registerToEvent(userId: Int, eventId: Int, complition: @escaping (Bool) -> Void){
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.intra.42.fr"
        urlComponents.path = "/v2/event_users"
        urlComponents.queryItems = [
            .init(name: "event_id", value: "\(eventId)"),
            .init(name: "user_id", value: "\(userId)")
        ]
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "POST"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard let data = data, error == nil else { return }
            complition(true)
//            try! print(JSONSerialization.jsonObject(with: data))
        }.resume()
    }
}
