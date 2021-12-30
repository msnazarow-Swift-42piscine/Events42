//
//  JSONExtention.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import Foundation

extension JSONDecoder {
    /// Assign multiple DateFormatter to dateDecodingStrategy
    ///
    /// Usage :
    ///
    ///      decoder.dateDecodingStrategyFormatters = [ DateFormatter.standard, DateFormatter.yearMonthDay ]
    ///
    /// The decoder will now be able to decode two DateFormat, the 'standard' one and the 'yearMonthDay'
    ///
    /// Throws a 'DecodingError.dataCorruptedError' if an unsupported date format is found while parsing the document
    var dateDecodingStrategyFormatters: [DateFormatter]? {
        @available(*, unavailable, message: "This variable is meant to be set only")
        get { nil }
        set {
            guard let formatters = newValue else { return }
            self.dateDecodingStrategy = .custom { decoder in
                let container = try decoder.singleValueContainer()
                let dateString = try container.decode(String.self)

                for formatter in formatters {
                    if let date = formatter.date(from: dateString) { return date }
                }
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateString)")
            }
        }
    }
}

extension JSONDecoder {
	static let intraSecondsSince1970: JSONDecoder = {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .secondsSince1970
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		return decoder
	}()

	static let intraIso8601Full: JSONDecoder = {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		decoder.dateDecodingStrategyFormatters = [.iso8601Full]
		return decoder
	}()
}
