//
//  IntraAPIError.swift
//  Events21
//
//  Created by out-nazarov2-ms on 07.10.2021.
//

import Foundation

struct IntraAPIError: Codable, Error {
    let error: String
    var errorDescription: String?
    var message: String?
    var statusCode: Int?
}
