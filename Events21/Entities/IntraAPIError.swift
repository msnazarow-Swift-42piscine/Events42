//
//  IntraAPIError.swift
//  Events21
//
//  Created by out-nazarov2-ms on 07.10.2021.
//

import Foundation

struct IntraAPIError: Codable, Error {
    let error: String
    var errorDescription: String? = nil
    var message: String? = nil
    var statusCode: Int? = nil
}

