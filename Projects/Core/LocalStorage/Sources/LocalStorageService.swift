//
//  LocalStorageService.swift
//  CoreLocalStorageInterface
//
//  Created by 지연 on 9/3/24.
//

import Foundation

import CoreLocalStorageInterface

public final class LocalStorageService: LocalStorageProtocol {
    public let userSettings: UserSettingsStorageProtocol
    public let newsData: NewsDataStorageProtocol
    public let appState: AppStateStorageProtocol
    
    public init(userSettings: UserSettingsStorageProtocol = UserDefaultsUserSettings(),
                newsData: NewsDataStorageProtocol = UserDefaultsNewsData(),
                appState: AppStateStorageProtocol = UserDefaultsAppState()) {
        self.userSettings = userSettings
        self.newsData = newsData
        self.appState = appState
    }
}
