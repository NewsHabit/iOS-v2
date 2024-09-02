//
//  SettingsType.swift
//  FeatureMain
//
//  Created by 지연 on 9/1/24.
//

import Foundation

public enum SettingsType: CaseIterable {
    case profile
    case myNewsHabit
    case notification
    case developer
    
    public var title: String {
        switch self {
        case .profile:      "프로필"
        case .myNewsHabit:  "나의 뉴빗"
        case .notification: "알림"
        case .developer:    "개발자 정보"
        }
    }
    
    public var imageName: String {
        switch self {
        case .profile:      "person.fill"
        case .myNewsHabit:  "newspaper"
        case .notification: "bell"
        case .developer:    "info.circle"
        }
    }
}
