//
//  UserDefaultsUserSettings.swift
//  CoreLocalStorageInterface
//
//  Created by 지연 on 9/3/24.
//

import Foundation

import CoreLocalStorageInterface
import Shared

public final class UserDefaultsUserSettings: UserSettingsStorageProtocol {
    public init() {}
    
    @UserDefaultsData(key: "nickname", defaultValue: "사용자")
    public var nickname: String
    
    @UserDefaultsData(key: "selectedCategories", defaultValue: [CategoryType.itScience])
    public var selectedCategories: [CategoryType]
    
    @UserDefaultsData(key: "dailyNewsCount", defaultValue: DailyNewsCountType.three)
    public var dailyNewsCount: DailyNewsCountType

    @UserDefaultsData(key: "isNotificationEnabled", defaultValue: false)
    public var isNotificationEnabled: Bool
    
    @UserDefaultsData(key: "notificationTime", defaultValue: "09:00 AM")
    public var notificationTime: String
}
