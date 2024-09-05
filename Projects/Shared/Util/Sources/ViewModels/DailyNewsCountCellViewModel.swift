//
//  DailyNewsCountCellViewModel.swift
//  SharedUtil
//
//  Created by 지연 on 9/6/24.
//

import Foundation

public struct DailyNewsCountCellViewModel: Hashable {
    public var count: DailyNewsCountType
    public var isSelected: Bool
    
    public init(count: DailyNewsCountType, isSelected: Bool) {
        self.count = count
        self.isSelected = isSelected
    }
}
