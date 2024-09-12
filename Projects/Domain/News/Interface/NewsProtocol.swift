//
//  NewsProtocol.swift
//  DomainNewsInterface
//
//  Created by 지연 on 9/12/24.
//

import Combine
import Foundation

public protocol NewsProtocol {
    func getDailyNews(categories: [String], count: Int) -> AnyPublisher<DailyNewsResponse, Error>
    func getHotNews() -> AnyPublisher<HotNewsResponse, Error>
}
