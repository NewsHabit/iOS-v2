//
//  DailyNews.swift
//  SharedUtil
//
//  Created by 지연 on 9/15/24.
//

import Foundation

public struct DailyNews: Codable, Hashable {
    public let title: String
    public let category: String
    public let naverUrl: String
    public let imgLink: String
    public let description: String
}
