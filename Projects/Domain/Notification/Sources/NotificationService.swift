//
//  NotificationService.swift
//  DomainNotification
//
//  Created by 지연 on 9/6/24.
//

import Combine
import UserNotifications

import Core
import DomainNotificationInterface
import Shared

public final class NotificationService: NotificationProtocol {
    private let localStorage: LocalStorageProtocol
    private var cancellables = Set<AnyCancellable>()
    private let identifier = "NewsHabit"
    private let notificationCenter: UNUserNotificationCenter
    
    public init(
        localStorage: LocalStorageProtocol,
        notificationCenter: UNUserNotificationCenter = .current()
    ) {
        self.localStorage = localStorage
        self.notificationCenter = notificationCenter
    }
    
    public func requestNotificationPermission() -> AnyPublisher<Bool, Never> {
        Deferred {
            Future { [weak self] promise in
                self?.notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
                    promise(.success(granted))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func checkNotificationPermission() -> AnyPublisher<UNAuthorizationStatus, Never> {
        Deferred {
            Future { [weak self] promise in
                self?.notificationCenter.getNotificationSettings { settings in
                    promise(.success(settings.authorizationStatus))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func scheduleNotification() -> AnyPublisher<Void, Error> {
        cancelNotification()
            .flatMap { [weak self] _ -> AnyPublisher<Void, Error> in
                guard let self = self else {
                    return Fail(error: NSError(
                        domain: "NotificationService",
                        code: 0,
                        userInfo: nil
                    )).eraseToAnyPublisher()
                }
                
                return self.createAndScheduleNotification()
            }
            .eraseToAnyPublisher()
    }
    
    private func createAndScheduleNotification() -> AnyPublisher<Void, Error> {
        Deferred {
            Future { [weak self] promise in
                guard let self = self else { return }
                
                let content = self.createNotificationContent()
                let trigger = self.createNotificationTrigger()
                let request = UNNotificationRequest(
                    identifier: self.identifier,
                    content: content,
                    trigger: trigger
                )
                
                self.notificationCenter.add(request) { error in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        promise(.success(()))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func createNotificationContent() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "뉴스를 습관처럼"
        content.body = "\(localStorage.userSettings.nickname)님을 위한 뉴스가 도착했어요"
        content.sound = .default
        return content
    }
    
    private func createNotificationTrigger() -> UNCalendarNotificationTrigger {
        let dateComponents = Calendar.current.dateComponents(
            [.hour, .minute],
            from: localStorage.userSettings.notificationTime.toTimeAsDate()!
        )
        return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    }
    
    public func cancelNotification() -> AnyPublisher<Void, Never> {
        Deferred {
            Future { [weak self] promise in
                self?.notificationCenter.removePendingNotificationRequests(
                    withIdentifiers: [self?.identifier ?? ""]
                )
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func updateNotificationSettings() {
        if localStorage.userSettings.isNotificationEnabled {
            scheduleNotification()
                .sink(receiveCompletion: { _ in }, receiveValue: { })
                .store(in: &cancellables)
        } else {
            cancelNotification()
                .sink(receiveCompletion: { _ in }, receiveValue: { })
                .store(in: &cancellables)
        }
    }
}
