//
//  NewsService.swift
//  DomainNewsInterface
//
//  Created by 지연 on 9/12/24.
//

import Combine
import Foundation

import Core
import DomainNewsInterface

public class NewsService: NewsProtocol {
    private let networkService: NetworkProtocol
    
    public init(networkService: NetworkProtocol) {
        self.networkService = networkService
    }
    
    public func getDailyNews(categories: [String], count: Int)
    -> AnyPublisher<DailyNewsResponse, Error> {
        return networkService
            .execute(NewsHabitEndpoint.getDailyNews(categories: categories,count: count))
            .eraseToAnyPublisher()
    }
    
    public func getHotNews() -> AnyPublisher<HotNewsResponse, Error> {
        return networkService
            .execute(NewsHabitEndpoint.getHotNews)
            .eraseToAnyPublisher()
    }
}
