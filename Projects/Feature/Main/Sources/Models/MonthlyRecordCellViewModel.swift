//
//  MonthlyRecordCellViewModel.swift
//  FeatureMain
//
//  Created by 지연 on 9/13/24.
//

import Foundation

public struct MonthlyRecordCellViewModel: Hashable {
    let day: String?
    var isRead: Bool
    let isToday: Bool
    
    public init(day: String?, isRead: Bool, isToday: Bool) {
        self.day = day
        self.isRead = isRead
        self.isToday = isToday
    }
}
