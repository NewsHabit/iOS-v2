//
//  CategoryType.swift
//  SharedUtil
//
//  Created by 지연 on 9/3/24.
//

import Foundation

public enum CategoryType: Codable, CaseIterable {
    case politics
    case economy
    case society
    case world
    case lifestyleCulture
    case itScience
    
    public var name: String {
        switch self {
        case .politics:         "정치"
        case .economy:          "경제"
        case .society:          "사회"
        case .world:            "세계"
        case .lifestyleCulture: "생활/문화"
        case .itScience:        "IT/과학"
        }
    }
    
    public var apiIdentifier: String {
        switch self {
        case .politics:         "POLITICS"
        case .economy:          "ECONOMY"
        case .society:          "SOCIETY"
        case .world:            "WORLD"
        case .lifestyleCulture: "LIFESTYLE_CULTURE"
        case .itScience:        "IT_SCIENCE"
        }
    }
    
    public static func convertAPIIdentifier(from apiIdentifier: String) -> String? {
        guard let category = Self.allCases.first(where: { $0.apiIdentifier == apiIdentifier })
        else { return nil }
        return category.name
    }
}
