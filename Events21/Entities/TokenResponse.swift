//
//  TokenResponse.swift
//  Events21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//

import Foundation

struct TokenResponse: Codable {
    let accessToken: String
    let createdAt: Date
    let expiresIn: Int64
    let refreshToken: String
    let scope: String
    let tokenType: String
}
