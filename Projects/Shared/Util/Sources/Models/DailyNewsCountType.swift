//
//  DailyNewsCountType.swift
//  SharedUtil
//
//  Created by 지연 on 9/3/24.
//

import Foundation

public enum DailyNewsCountType: Int, Codable, CaseIterable {
    case three = 3
    case four = 4
    case five = 5
    
    public static func dailyNewsCount(at index: Int) -> Self {
        return self.allCases[index]
    }
}
