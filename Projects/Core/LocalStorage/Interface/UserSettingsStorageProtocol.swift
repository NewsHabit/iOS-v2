//
//  UserSettingsStorageProtocol.swift
//  CoreLocalStorageInterface
//
//  Created by 지연 on 9/3/24.
//

import Foundation

import Shared

public protocol UserSettingsStorageProtocol {
    var nickname: String { get set }                    // 사용자가 설정한 닉네임
    var selectedCategories: [CategoryType] { get set }  // 사용자가 선택한 뉴스 카테고리
    var dailyNewsCount: DailyNewsCountType { get set }  // 사용자가 설정한 일일 뉴스 개수
    var isNotificationEnabled: Bool { get set }         // 앱 알림 활성화 여부
    var notificationTime: String { get set }            // 사용자가 설정한 알림 시간
}
