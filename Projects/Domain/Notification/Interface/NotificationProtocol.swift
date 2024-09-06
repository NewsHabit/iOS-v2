//
//  NotificationProtocol.swift
//  DomainNotificationInterface
//
//  Created by 지연 on 9/6/24.
//

import Combine
import UserNotifications

public protocol NotificationProtocol {
    func requestNotificationPermission() -> AnyPublisher<Bool, Never>
    func checkNotificationPermission() -> AnyPublisher<UNAuthorizationStatus, Never>
    func scheduleNotification() -> AnyPublisher<Void, Error>
    func cancelNotification() -> AnyPublisher<Void, Never>
    func updateNotificationSettings()
}
