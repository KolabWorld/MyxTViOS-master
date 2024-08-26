//
//  IOSLogAPIData.swift
//  WXRKSTUDY
//
//  Created by Karamjeet Singh on 15/08/22.
//

import Foundation
import RealmSwift
import SwiftyJSON

class IOSLogAPIData: Object {
  
    @objc dynamic var id = 0
    @objc dynamic var user_id = ""
    @objc dynamic var user_type = "ios"
    @objc dynamic var wxrk_per_minute = ""
    @objc dynamic var total_app_usage_time: Double  = 000
    @objc dynamic var day_total_time: Double  = 000
    @objc dynamic var day_idle_time: Int64  = 000
    @objc dynamic var wxrk_earned: Double  = 0.0
    @objc dynamic var wxrk_spent: Double  = 000
    @objc dynamic var wxrk_balance: Double  = 000
    @objc dynamic var status   = ""
    @objc dynamic var created_at   = ""
    @objc dynamic var updated_at  = ""
    @objc dynamic var android_usage_log_id  = ""
    @objc dynamic var app_summary_log_id  = ""
    @objc dynamic var log_date  = ""
    @objc dynamic var watchTime = ""
    @objc dynamic var total_idle_time: Double  = 000
    convenience required init(withJSON json : JSON) {
        
        self.init()
        self.total_idle_time = json["data"]["total_idle_time"].doubleValue
        self.id = json["data"]["daily_wise_summary_data"]["id"].intValue
        self.user_id = json["data"]["daily_wise_summary_data"]["user_id"].stringValue
        self.user_type = json["data"]["daily_wise_summary_data"]["user_type"].stringValue
        self.android_usage_log_id = json["data"]["daily_wise_summary_data"]["android_usage_log_id"].stringValue
        self.app_summary_log_id = json["data"]["daily_wise_summary_data"]["app_summary_log_id"].stringValue
        self.log_date = json["data"]["daily_wise_summary_data"]["log_date"].stringValue
        self.watchTime =  json["data"]["daily_wise_summary_data"]["watch_time"].stringValue
        self.wxrk_per_minute = json["data"]["daily_wise_summary_data"]["wxrk_per_minute"].stringValue
        self.total_app_usage_time = json["data"]["daily_wise_summary_data"]["total_app_usage_time"].doubleValue
        self.day_total_time = json["data"]["daily_wise_summary_data"]["day_total_time"].doubleValue
        self.day_idle_time = json["data"]["daily_wise_summary_data"]["day_idle_time"].int64Value
        self.wxrk_earned = json["data"]["daily_wise_summary_data"]["wxrk_earned"].doubleValue
        self.wxrk_spent = json["data"]["daily_wise_summary_data"]["wxrk_spent"].doubleValue
        self.wxrk_balance = json["data"]["daily_wise_summary_data"]["wxrk_balance"].doubleValue
        self.status = json["data"]["daily_wise_summary_data"]["status"].stringValue
        self.created_at = json["data"]["daily_wise_summary_data"]["created_at"].stringValue
        self.updated_at = json["data"]["daily_wise_summary_data"]["updated_at"].stringValue
    }
}
