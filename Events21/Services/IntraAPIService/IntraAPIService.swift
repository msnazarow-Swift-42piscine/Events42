//
//  IntraAPIService.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//

import Foundation

protocol IntraAPIServiceProtocol {
    func getFutureEvents(campusId: Int?,
                         cursusId: Int?,
                         sort: [String], filter: [String: [String]],
                         completion: @escaping (Result<[EventResponse], IntraAPIError>) -> Void)
    func getEvents(campusId: Int?,
                   cursusId: Int?,
                   sort: [String],
                   filter: [String: [String]],
                   completion: @escaping (Result<[EventResponse], IntraAPIError>) -> Void)
    func getMe(completion: @escaping (Result<MeResponse, IntraAPIError>) -> Void)
    func registerToEvent(eventId: Int, completion: @escaping (Result<Bool, IntraAPIError>) -> Void)
    func getUserEvents(completion: @escaping (Result<[EventUsersResponse], IntraAPIError>) -> Void) 
}

protocol IntraAPIServiceAuthProtocol {
    func getToken(completion: @escaping (Result<String, IntraAPIError>) -> Void)
    func getUserCode(completion: @escaping (Result<String, IntraAPIError>) -> Void)
    func removeCode()
    func removeToken()
    func hasToken() -> Bool
}

extension IntraAPIServiceProtocol {
    func getFutureEvents(sort: [String], filter: [String: [String]], completion: @escaping (Result<[EventResponse], IntraAPIError>) -> Void) {
        getFutureEvents(campusId: nil,
                        cursusId: nil,
                        sort: sort,
                        filter: filter,
                        completion: completion)
    }
}

class IntraAPIService: NSObject, IntraAPIServiceProtocol, IntraAPIServiceAuthProtocol {
    let redirecdedUrl = "events21://events21"
    let uid = "304465722129fb447b62e46570c95cbad281250121c76f71a64fd9b0098baaa9"
    let secret = "9dd7cc32e3dd76eccfcd4587cd3a435ac3826d35c86715c92207aa8b868f06d1"
    var token = KeychainHelper.standard.read(service: .token, account: .intra42, type: TokenResponse.self)
    var code = KeychainHelper.standard.read(service: .code, account: .intra42, type: String.self)
    var me: MeResponse!

    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategyFormatters = [.iso8601Full]
        return decoder
    }()

    var urlComponents: URLComponents = {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.intra.42.fr"
        return urlComponents
    }()

    var request: URLRequest{
        var request = URLRequest(url: urlComponents.url!)
        if let token = token {
            request.setValue("Bearer \(token.accessToken)", forHTTPHeaderField: "Authorization")
        }
        return request
    }

    static let shared = IntraAPIService()

    private override init(){
        super.init()
    }

}
