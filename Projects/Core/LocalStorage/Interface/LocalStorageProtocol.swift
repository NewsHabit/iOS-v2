//
//  LocalStorageProtocol.swift
//  CoreLocalStorageInterface
//
//  Created by 지연 on 9/3/24.
//

import Foundation

public protocol LocalStorageProtocol {
    var userSettings: UserSettingsStorageProtocol { get set }
    var newsData: NewsDataStorageProtocol { get set }
    var appState: AppStateStorageProtocol { get set }
}
