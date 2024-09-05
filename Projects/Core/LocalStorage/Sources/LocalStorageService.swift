//
//  LocalStorageService.swift
//  CoreLocalStorageInterface
//
//  Created by 지연 on 9/3/24.
//

import Foundation

import CoreLocalStorageInterface

public final class LocalStorageService: LocalStorageProtocol {
    public var userSettings: UserSettingsStorageProtocol
    public var newsData: NewsDataStorageProtocol
    public var appState: AppStateStorageProtocol
    
    public init(userSettings: UserSettingsStorageProtocol = UserDefaultsUserSettings(),
                newsData: NewsDataStorageProtocol = UserDefaultsNewsData(),
                appState: AppStateStorageProtocol = UserDefaultsAppState()) {
        self.userSettings = userSettings
        self.newsData = newsData
        self.appState = appState
    }
}
