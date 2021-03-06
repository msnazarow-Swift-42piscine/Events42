//
//  Date+Extensions.swift
//

import Foundation

extension Date {
	static var MondeyOfThisWeek: Date? {
		let calendar = Calendar(identifier: .iso8601)
		return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))
	}

	var isToday: Bool {
		Calendar.current.isDateInToday(self)
	}

	var isTomorrow: Bool {
		Calendar.current.isDateInTomorrow(self)
	}

	var isYesterday: Bool {
		Calendar.current.isDateInYesterday(self)
	}

	var weekDay: String {
		let formatter = DateFormatter()
		formatter.dateFormat = "EEEE"
		formatter.locale = Locale(identifier: "ru_RU")
		return formatter.string(from: self)
	}

	var dateSlashString: String {
		DateFormatter.YYYYMMdd.string(from: self)
	}

	var iso8601Full: String {
		DateFormatter.iso8601Full.string(from: self)
	}

	func byAddingDay(_ day: Int) -> Date {
		var components = DateComponents()
		components.day = day
		return Calendar.current.date(byAdding: components, to: self)!
	}
}

extension Data {
	var html2AttributedString: NSAttributedString? {
		do {
			return try NSAttributedString(
				data: self,
				options: [
					.documentType: NSAttributedString.DocumentType.html,
					.characterEncoding: String.Encoding.utf8.rawValue
				],
				documentAttributes: nil)
		} catch {
			print("error:", error)
			return  nil
		}
	}
	var html2String: String { html2AttributedString?.string ?? "" }
}


extension Data {
	var jsonString: String? {
		guard
			let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
			let pretty = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
		else { return nil }
		return String(data: pretty, encoding: .utf8)?.replacingOccurrences(of: "\\", with: "")
	}
}
