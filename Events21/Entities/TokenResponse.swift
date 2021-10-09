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
    let expiresIn: Date
    let refreshToken: String
    let scope: String
    let tokenType: String
}
