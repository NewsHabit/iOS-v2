//
//  NewsDataStorageProtocol.swift
//  CoreLocalStorageInterface
//
//  Created by 지연 on 9/3/24.
//

import Foundation

import Shared

public protocol NewsDataStorageProtocol {
    var cachedDailyNews: [DailyNewsData] { get set }    // 캐시된 오늘의 뉴스 데이터
    var totalDaysAllNewsRead: Int { get set }           // 모든 뉴스를 읽은 누적 일수
    var monthlyCompletionDates: [String] { get set }    // 해당 월에 모든 뉴스를 읽은 날짜들
}
