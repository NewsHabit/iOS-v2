//
//  HotNewsResponse.swift
//  DomainNewsInterface
//
//  Created by 지연 on 9/12/24.
//

import Foundation

public struct HotNewsResponse: Codable {
    public let hotNewsResponseDtoList: [HotNews]
}
