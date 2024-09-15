//
//  DailyNewsData.swift
//  SharedUtil
//
//  Created by 지연 on 9/15/24.
//

import Foundation

public struct DailyNewsData: Codable, Hashable {
    public let dailyNews: DailyNews
    public var isRead: Bool
    
    public init(dailyNews: DailyNews, isRead: Bool) {
        self.dailyNews = dailyNews
        self.isRead = isRead
    }
}
