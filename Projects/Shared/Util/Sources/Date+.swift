//
//  Date+.swift
//  SharedUtil
//
//  Created by 지연 on 8/30/24.
//

import Foundation

private enum DateFormat {
    static let fullDateTime = "yyyy년 M월 d일 HH:00"
    static let shortDate = "yyMMdd"
    static let timeWithPeriod = "hh:mm a"
    static let shortYearMonth = "yyMM"
    static let dayOnly = "dd"
    static let fullYearMonth = "yyyy년 MM월"
}

private final class DateFormatterCache {
    static let shared = DateFormatterCache()
    private var cache: [String: DateFormatter] = [:]
    
    private init() {}
    
    func formatter(for format: String, locale: Locale = Locale(identifier: "en_US_POSIX"), timeZone: TimeZone = TimeZone(identifier: "Asia/Seoul")!) -> DateFormatter {
        if let cached = cache[format] {
            return cached
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = locale
        formatter.timeZone = timeZone
        
        cache[format] = formatter
        return formatter
    }
}

extension Date {
    /// "yyyy년 M월 d일 HH:mm"
    public func formatAsFullDateTime() -> String {
        let formatter = DateFormatterCache.shared.formatter(for: DateFormat.fullDateTime)
        return formatter.string(from: self)
    }
    
    /// "yyMMdd"
    public func formatAsShortDate() -> String {
        let formatter = DateFormatterCache.shared.formatter(for: DateFormat.shortDate)
        return formatter.string(from: self)
    }
    
    /// "hh:mm a"
    public func formatAsTimeWithPeriod() -> String {
        let formatter = DateFormatterCache.shared.formatter(for: DateFormat.timeWithPeriod)
        return formatter.string(from: self)
    }
    
    /// "yyMM"
    public func formatAsShortYearMonth() -> String {
        let formatter = DateFormatterCache.shared.formatter(for: DateFormat.shortYearMonth)
        return formatter.string(from: self)
    }
    
    /// "dd"
    public func formatAsDayOnly() -> String {
        let formatter = DateFormatterCache.shared.formatter(for: DateFormat.dayOnly)
        return formatter.string(from: self)
    }
    
    /// "yyyy년 MM월"
    public func formatAsFullYearMonth() -> String {
        let formatter = DateFormatterCache.shared.formatter(for: DateFormat.fullYearMonth)
        return formatter.string(from: self)
    }
}
