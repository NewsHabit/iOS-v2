//
//  NewsHabitEndpoint.swift
//  CoreNetwork
//
//  Created by 지연 on 9/12/24.
//

import Foundation

import CoreNetworkInterface
import Shared

import Alamofire

public enum NewsHabitEndpoint<R: Decodable> {
    case getDailyNews(categories: [String], count: Int)
    case getHotNews
}

extension NewsHabitEndpoint: EndpointSpecifiable {
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
        case let .getDailyNews(categories, count):
            return ["categories": categories, "cnt": count]
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
