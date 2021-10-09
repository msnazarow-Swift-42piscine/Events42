//
//  IntraAPIService+Auth.swift
//  Events21
//
//  Created by out-nazarov2-ms on 09.10.2021.
//

import Foundation
import AuthenticationServices

extension IntraAPIService {
    private func getToken(with code: String, completion: @escaping (Result<String, IntraAPIError>) -> Void) {
        urlComponents.path = "/oauth/token"
        urlComponents.queryItems = [
            .init(name: "grant_type", value: "authorization_code"),
            .init(name: "client_id", value: uid),
            .init(name: "client_secret", value: secret),
            .init(name: "code", value: code),
            .init(name: "redirect_uri", value: redirecdedUrl)
        ]
        var request = URLRequest(url: urlComponents.url!)
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
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let error = try? decoder.decode(IntraAPIError.self, from: data) {
                    completion(.failure(error))
                    return
                }



                let tokenResponse = try decoder.decode(TokenResponse.self, from: data)



                self.token = tokenResponse
                KeychainHelper.standard.save(tokenResponse, service: "token", account: "intra42")
                completion(.success(tokenResponse.accessToken))
            } catch  {
                completion(.failure(IntraAPIError(error: "JSONDecoderError", errorDescription: error.localizedDescription)))
            }

        }.resume()
    }

    func getAuthRequest() -> URLRequest {
        urlComponents.path = "/oauth/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: uid),
            URLQueryItem(name: "redirect_uri", value: redirecdedUrl),
            URLQueryItem(name: "response_type", value: "code")
        ]
        return URLRequest(url: urlComponents.url!)
    }

    func getUserCode(completion: @escaping (Result<String, IntraAPIError>) -> Void) {
        urlComponents.path = "/oauth/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: uid),
            URLQueryItem(name: "scope", value: "public projects profile elearning tig forum"),
            URLQueryItem(name: "redirect_uri", value: redirecdedUrl),
            URLQueryItem(name: "response_type", value: "code")
        ]
        let session = ASWebAuthenticationSession(url: urlComponents.url!, callbackURLScheme: "events21%3A%2F%2Fevents21") { url, error in
            if let error = error {
                completion(.failure(IntraAPIError(error: "Authentification Error", errorDescription: error.localizedDescription)))
                return
            }
            guard let url = url else {
                completion(.failure(IntraAPIError(error: "Authentification Error")))
                return
            }
            if let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: true)?.queryItems,
               let code = queryItems.first(where: {$0.name == "code"})?.value {
                completion(.success(code))
            }
        }
        if #available(iOS 13.0, *) {
            session.presentationContextProvider = self
        }
        DispatchQueue.main.async {
            session.start()
        }
    }

    func handleCode(result: Result<String, IntraAPIError>, completion: @escaping (Result<String, IntraAPIError>) -> Void) {
        switch result {
        case .success(let code):
            self.code = code
            KeychainHelper.standard.save(code, service: .code, account: .intra42)
            self.getToken(with: code, completion: completion)
        case .failure(let error):
            completion(.failure(error))
        }
    }

    func getToken(completion: @escaping (Result<String, IntraAPIError>) -> Void) {
        if let token = token {
            if token.createdAt.addingTimeInterval(TimeInterval(token.expiresIn)) > Date() {
                completion(.success(token.accessToken))
            } else {
                refreshToken { [self] result in
                    switch result {
                    case .success(let token):
                        completion(.success(token))
                    case .failure(let error):
                        if let code = code {
                            getToken(with: code) { result in
                                switch result {
                                case .success(let token):
                                    completion(.success(token))
                                case .failure(let error):
                                    self.getUserCode { result in
                                        self.handleCode(result: result, completion: completion)
                                    }
                                }
                            }
                        } else {
                            getUserCode { result in
                                self.handleCode(result: result, completion: completion)
                            }
                        }
                    }
                }
            }
        } else if let code = code {
            getToken(with: code) { result in
                switch result {
                case .success(let token):
                    completion(.success(token))
                case .failure(let error):
                    self.getUserCode { result in
                        self.handleCode(result: result, completion: completion)
                    }
                }
            }
        } else {
            getUserCode { result in
                self.handleCode(result: result, completion: completion)
            }
        }
    }


    func refreshToken(completion: @escaping (Result<String, IntraAPIError>) -> Void) {
        urlComponents.path = "/oauth/token"
        urlComponents.queryItems = [
            .init(name: "grant_type", value: "refresh_token"),
            .init(name: "client_id", value: uid),
            .init(name: "client_secret", value: secret),
            .init(name: "redirect_uri", value: redirecdedUrl),
            .init(name: "refresh_token", value: "\(token!.refreshToken)")
        ]
        var request = URLRequest(url: urlComponents.url!)
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
                let decoder: JSONDecoder = {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    return decoder
                }()
                if let error = try? decoder.decode(IntraAPIError.self, from: data) {
                    completion(.failure(error))
                    return
                }
                let token = try decoder.decode(TokenResponse.self, from: data)
                self.token = token
                KeychainHelper.standard.save(token, service: .token, account: .intra42)
//                KeychainHelper.standard.save(data, service: .token, account: .intra42)
                completion(.success(token.accessToken))
            }
            catch  {
                completion(.failure(IntraAPIError(error: "JSONDecoderError", errorDescription: error.localizedDescription)))
            }

        }.resume()
    }
    func removeToken(){
        token = nil
        KeychainHelper.standard.delete(service: .token, account: .intra42)
    }

    func removeCode(){
        code = nil
        KeychainHelper.standard.delete(service: .code, account: .intra42)
    }

    func hasToken() -> Bool {
        if let token = token, token.createdAt.addingTimeInterval(TimeInterval(token.expiresIn)) > Date() {
            return true
        } else {
            return false
        }
    }

}

extension IntraAPIService: ASWebAuthenticationPresentationContextProviding {
    @available(iOS 13.0, *)
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }!
    }
}
