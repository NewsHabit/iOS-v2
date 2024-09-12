//
//  NewsAPIEndpoint.swift
//  CoreNetworkInterface
//
//  Created by 지연 on 9/12/24.
//

import Foundation

import Alamofire

public enum NewsAPIEndpoint<R: Decodable> {
    case getDailyNews(categories: String, cnt: Int)
    case getHotNews
}

extension NewsAPIEndpoint: EndpointSpecifiable {
    public typealias Response = R
    
    public var path: String {
        switch self {
        case .getDailyNews:
            return "/api/recommendations"
        case .getHotNews:
            return "/api/issues"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .getDailyNews, .getHotNews:
            return .get
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case let .getDailyNews(categories, cnt):
            return ["categories": categories, "cnt": cnt]
        case .getHotNews:
            return nil
        }
    }
    
    public var encoding: URLEncoding {
        switch self {
        case .getDailyNews:
            return .init(
                destination: .queryString,
                arrayEncoding: .noBrackets,
                boolEncoding: .literal
            )
        case .getHotNews:
            return .default
        }
    }
}
