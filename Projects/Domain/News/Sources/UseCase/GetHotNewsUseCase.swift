//
//  GetHotNewsUseCase.swift
//  DomainNewsInterface
//
//  Created by 지연 on 9/12/24.
//

import Combine
import Foundation

import DomainNewsInterface

public struct GetHotNewsUseCase: UseCase {
    private let newsService: NewsProtocol
    
    public init(newsService: NewsProtocol) {
        self.newsService = newsService
    }
    
    public func execute(_ input: Void) -> AnyPublisher<HotNewsResponse, Error> {
        return newsService.getHotNews()
    }
}
