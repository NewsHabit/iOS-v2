//
//  AppStateStorageProtocol.swift
//  CoreLocalStorageInterface
//
//  Created by 지연 on 9/3/24.
//

import Foundation

public protocol AppStateStorageProtocol {
    var isOnboardingCompleted: Bool { get set } // 온보딩 과정을 완료했는지 여부
    var lastAccessDate: String { get set }      // 마지막 접속 날짜
}
