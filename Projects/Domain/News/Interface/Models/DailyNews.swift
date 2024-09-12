//
//  DailyNews.swift
//  DomainNewsInterface
//
//  Created by 지연 on 9/12/24.
//

import Foundation

public struct DailyNews: Codable {
    let title: String
    let category: String
    let naverUrl: String
    let imgLink: String
    let description: String
}
