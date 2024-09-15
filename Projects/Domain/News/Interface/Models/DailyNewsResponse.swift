//
//  DailyNewsResponse.swift
//  DomainNewsInterface
//
//  Created by 지연 on 9/12/24.
//

import Foundation

import Shared

public struct DailyNewsResponse: Codable {
    public let recommendedNewsResponseDtoList: [DailyNews]
}
