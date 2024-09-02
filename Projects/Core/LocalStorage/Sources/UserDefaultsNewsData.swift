//
//  UserDefaultsNewsData.swift
//  CoreLocalStorageInterface
//
//  Created by 지연 on 9/3/24.
//

import Foundation

import CoreLocalStorageInterface

public final class UserDefaultsNewsData: NewsDataStorageProtocol {
    public init() {}
    
    @UserDefaultsData(key: "totalDaysAllNewsRead", defaultValue: 0)
    public var totalDaysAllNewsRead: Int
    
    @UserDefaultsData(key: "monthlyCompletionDates", defaultValue: [])
    public var monthlyCompletionDates: [Date]
}
