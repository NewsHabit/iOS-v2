//
//  UserDefaultsAppState.swift
//  CoreLocalStorageInterface
//
//  Created by 지연 on 9/3/24.
//

import Foundation

import CoreLocalStorageInterface

public final class UserDefaultsAppState: AppStateStorageProtocol {
    public init() {}
    
    @UserDefaultsData(key: "isOnboardingCompleted", defaultValue: false)
    public var isOnboardingCompleted: Bool
    
    @UserDefaultsData(key: "lastAccessDate", defaultValue: "")
    public var lastAccessDate: String
}
