//
//  WatchTimeAPIModel.swift
//  WXRKSTUDY
//
//  Created by Karamjeet Singh on 08/11/22.
//

import Foundation

// MARK: - WatchTimeAPIModel
class WatchTimeAPIModel: Codable {
    let status: Int
    let data: WatchTimeAPIModelData
    let errors: Errors?
    init(status: Int, data: WatchTimeAPIModelData, errors: Errors?) {
        self.status = status
        self.data = data
        self.errors = errors

    }
}

// MARK: - WatchTimeAPIModelData
class WatchTimeAPIModelData: Codable {
    let message: String
    let data: WatchTimeData

    init(message: String, data: WatchTimeData) {
        self.message = message
        self.data = data
    }
}

// MARK: - DataData
class WatchTimeData: Codable {
    let todayWatchTime : Int?
    let todayWxrkBalance: String?
    let actualWxrkBalance: String?

    enum CodingKeys: String, CodingKey {
        case todayWatchTime = "today_watch_time"
        case todayWxrkBalance = "today_wxrk_balance"
        case actualWxrkBalance = "actual_wxrk_balance"
    }

    init(todayWatchTime: Int?, todayWxrkBalance: String?, actualWxrkBalance: String?) {
        self.todayWatchTime = todayWatchTime
        self.todayWxrkBalance = todayWxrkBalance
        self.actualWxrkBalance = actualWxrkBalance

    }
}
