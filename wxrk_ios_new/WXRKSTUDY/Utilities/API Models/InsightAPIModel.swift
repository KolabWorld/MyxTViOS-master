// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let insightAPIModel = try? newJSONDecoder().decode(InsightAPIModel.self, from: jsonData)

import Foundation

// MARK: - InsightAPIModel
struct InsightAPIModel: Codable {
    let status: Int
    let data: InsightAPIModelData
    let errors: Errors?
 
}

// MARK: - InsightAPIModelData
struct InsightAPIModelData: Codable {
    let message: String
    let data: InsightData
}

// MARK: - InsightData
struct InsightData: Codable {
    let iosAppPerformace: [IosAppPerformace]

    enum CodingKeys: String, CodingKey {
        case iosAppPerformace = "ios_app_performace"
    }
}

// MARK: - IosAppPerformace
struct IosAppPerformace: Codable {
    let id: Int
    let userID: String?
    let userType: String?
   // let androidUsageLogID, appSummaryLogID, logDate: JSONNull?
    let wxrkPerMinute: String?
    let totalAppUsageTime, dayTotalTime, dayIdleTime, watchTime: String?
    let wxrkEarned, wxrkSpent, wxrkBalance: String?
    let status: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case userType = "user_type"
//        case androidUsageLogID = "android_usage_log_id"
//        case appSummaryLogID = "app_summary_log_id"
//        case logDate = "log_date"
        case wxrkPerMinute = "wxrk_per_minute"
        case totalAppUsageTime = "total_app_usage_time"
        case dayTotalTime = "day_total_time"
        case dayIdleTime = "day_idle_time"
        case watchTime = "watch_time"
        case wxrkEarned = "wxrk_earned"
        case wxrkSpent = "wxrk_spent"
        case wxrkBalance = "wxrk_balance"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

