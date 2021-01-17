//
//  Date+Extensions.swift
//  Koombea Test
//
//  Created by Giovanny Orozco Loaiza on 16/01/21.
//

import Foundation

extension Date {
    private static let stringFormatter = DateFormatter()
    
    func toString(format: String, locale: Locale = .current) -> String {
        let formatter = Date.stringFormatter
        formatter.dateFormat = format
        formatter.locale = locale
        return formatter.string(from: self)
    }
    
    func dateFormatWithSuffix() -> String {
        return "MMM dd'\(daySuffix())'"
    }
    
    func daySuffix() -> String {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.day, from: self)
        let dayOfMonth = components.day
        switch dayOfMonth {
        case 1, 21, 31:
            return "st"
        case 2, 22:
            return "nd"
        case 3, 23:
            return "rd"
        default:
            return "th"
        }
    }
}

extension String {
    private static let formatter = DateFormatter()
    
    func toDate(format: String) -> Date? {
        let formatter = String.formatter
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}

enum Format: String {
    case serverFormat = "EEE MMM dd yyyy HH:mm:ss 'GMT-0500 (Colombia Standard Time)'"
}
