//
//  MyNewsHabitType.swift
//  FeatureMain
//
//  Created by 지연 on 9/2/24.
//

import Foundation

public enum MyNewsHabitType: CaseIterable {
    case category
    case todayNewsCount
    
    var title: String {
        switch self {
        case .category:         "카테고리"
        case .todayNewsCount:   "오늘의 뉴스 개수"
        }
    }
}
