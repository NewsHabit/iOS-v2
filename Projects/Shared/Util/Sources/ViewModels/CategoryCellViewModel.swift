//
//  CategoryCellViewModel.swift
//  SharedUtil
//
//  Created by 지연 on 9/6/24.
//

import Foundation

public struct CategoryCellViewModel: Hashable {
    public var category: CategoryType
    public var isSelected: Bool
    
    public init(category: CategoryType, isSelected: Bool) {
        self.category = category
        self.isSelected = isSelected
    }
}
