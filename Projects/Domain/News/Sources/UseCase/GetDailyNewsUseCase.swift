//
//  GetDailyNewsUseCase.swift
//  DomainNewsInterface
//
//  Created by 지연 on 9/12/24.
//

import Combine
import Foundation

import DomainNewsInterface

public struct GetDailyNewsUseCase: UseCase {
    private let newsService: NewsProtocol
    
    public init(newsService: NewsProtocol) {
        self.newsService = newsService
    }
    
    public func execute(_ input: (categories: String, count: Int)) 
    -> AnyPublisher<[DailyNews], Error> {
        return newsService.getDailyNews(categories: input.categories, count: input.count)
    }
}
