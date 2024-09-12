//
//  DailyNewsCellViewModel.swift
//  FeatureMain
//
//  Created by 지연 on 9/12/24.
//

import Foundation

import Domain

public struct DailyNewsCellViewModel: Hashable {
    let dailyNews: DailyNews
    var isRead: Bool
    
    public init(dailyNews: DailyNews, isRead: Bool) {
        self.dailyNews = dailyNews
        self.isRead = isRead
    }
}
