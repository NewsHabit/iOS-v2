//
//  Category.swift
//  FeatureOnboardingExample
//
//  Created by 지연 on 8/29/24.
//

import Foundation

public enum Category: CaseIterable {
    case politics
    case economy
    case society
    case world
    case lifestyleCulture
    case itScience
    
    public var name: String {
        switch self {
        case .politics: "정치"
        case .economy: "경제"
        case .society: "사회"
        case .world: "세계"
        case .lifestyleCulture: "생활/문화"
        case .itScience: "IT/과학"
        }
    }
}
