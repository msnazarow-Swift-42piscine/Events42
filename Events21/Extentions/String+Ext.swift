//
//  String+Ext.swift
//  Events21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//

import Foundation

extension String {
    static let token = "token"
    static let intra42 = "intra42"
    static let code = "code"
    static let myCursus = "my cursus"
    static let myCampus = "my campus"
    static let future = "future"
    static let didSubscribe = "subscribed"
    static let filters = "Filters"
    static let logOut = "LogOut"
    static let cursusId = "cursus_id"
    static let campusId = "campus_id"
    static let userId = "user_id"
    static let eventId = "event_id"
    static let syllabus = "Syllabus"
    static let campus = "Campus"
    static let type = "Type"
    static let inc = "\u{2191}"
    static let dec = "\u{2193}"
}

extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}
