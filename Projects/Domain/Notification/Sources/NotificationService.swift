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
    private var localStorageService: LocalStorageProtocol
    private var cancellables = Set<AnyCancellable>()
    private let identifier = "NewsHabit"
    private let notificationCenter: UNUserNotificationCenter
    
    public init(
        localStorageService: LocalStorageProtocol,
        notificationCenter: UNUserNotificationCenter = .current()
    ) {
        self.localStorageService = localStorageService
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
    
    public func scheduleNotification(at time: String? = nil) -> AnyPublisher<Void, Error> {
        cancelNotification()
            .flatMap { [weak self] _ -> AnyPublisher<Void, Error> in
                guard let self = self else {
                    return Fail(error: NSError(
                        domain: "NotificationService",
                        code: 0,
                        userInfo: nil
                    )).eraseToAnyPublisher()
                }
                if let time = time {
                    localStorageService.userSettings.notificationTime = time
                }
                return createAndScheduleNotification()
            }
            .eraseToAnyPublisher()
    }
    
    private func createAndScheduleNotification() -> AnyPublisher<Void, Error> {
        Deferred {
            Future { [weak self] promise in
                guard let self = self else { return }
                
                let content = createNotificationContent()
                let trigger = createNotificationTrigger()
                let request = UNNotificationRequest(
                    identifier: self.identifier,
                    content: content,
                    trigger: trigger
                )
                
                notificationCenter.add(request) { error in
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
        content.body = "\(localStorageService.userSettings.nickname)님을 위한 뉴스가 도착했어요"
        content.sound = .default
        return content
    }
    
    private func createNotificationTrigger() -> UNCalendarNotificationTrigger {
        let dateComponents = Calendar.current.dateComponents(
            [.hour, .minute],
            from: localStorageService.userSettings.notificationTime.toTimeAsDate()!
        )
        return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    }
    
    public func cancelNotification() -> AnyPublisher<Void, Never> {
        Deferred {
            Future { [weak self] promise in
                guard let self = self else { return promise(.success(())) }
                notificationCenter.removePendingNotificationRequests(
                    withIdentifiers: [identifier]
                )
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func updateNotificationSettings(isEnabled: Bool, time: String? = nil) {
        localStorageService.userSettings.isNotificationEnabled = isEnabled
        if isEnabled {
            scheduleNotification(at: time)
                .sink(receiveCompletion: { _ in }, receiveValue: { })
                .store(in: &cancellables)
        } else {
            cancelNotification()
                .sink(receiveCompletion: { _ in }, receiveValue: { })
                .store(in: &cancellables)
        }
    }
}
