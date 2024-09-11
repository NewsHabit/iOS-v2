//
//  MyNewsHabitViewFactory.swift
//  FeatureMain
//
//  Created by 지연 on 9/6/24.
//

import Foundation

import Core

public final class MyNewsHabitViewFactory {
    private let localStorageService: LocalStorageProtocol
    
    public init(localStorageService: LocalStorageProtocol) {
        self.localStorageService = localStorageService
    }
    
    public func makeCategoryViewController() -> CategoryViewController {
        let viewModel = CategoryViewModel(localStorageService: localStorageService)
        return CategoryViewController(viewModel: viewModel)
    }
    
    public func makeDailyNewsCountViewController() -> DailyNewsCountViewController {
        let viewModel = DailyNewsCountViewModel(localStorageService: localStorageService)
        return DailyNewsCountViewController(viewModel: viewModel)
    }
}
