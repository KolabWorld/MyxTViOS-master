//
//  File.swift
//  WXRKSTUDY
//
//  Created by Karamjeet Singh on 10/08/22.
//

import Foundation

class WxrsStudyAPI {
    
    static var apiVersion : String = "api/v1/"
    static var baseUrl : String = "https://staging-wxrk.staqo.com/\(apiVersion)"
    static var token : String = ""
    
    // Login/Signup
    static var loginAPI : String = "\(baseUrl)login"
    static var sendOtpAPI :  String = "\(baseUrl)send-otp"
    static var verifyOtpAPI :  String = "\(baseUrl)verify-otp"
    static var getDeleteUserAPI : String = "\(baseUrl)deactivate/user"

    // Profile
    static var profileAPI : String = "\(baseUrl)profile"
    
    // Sync Logs
    static var iOSlogsAPI :  String = "\(baseUrl)ios/app-logs"

    //Dashboard
    static var dashboardAPI : String = "\(baseUrl)dashboard"
    static var watchTimeAPI : String = "\(baseUrl)watch-time"
    // Wallet
    static var topTransactionsAPI : String = "\(baseUrl)top-transactions"
    static var transactionsAPI : String = "\(baseUrl)transactions"

    //Shop
    static var offerCategoriesAPI : String = "\(baseUrl)offer-categories"
    static var offerListAPI : String = "\(baseUrl)offers"
    static var buyOfferAPI : String = "\(baseUrl)buy-offer"
    
    //Events
    static var getEventsAPI : String = "\(baseUrl)events"
    static var joinEventAPI :  String = "\(baseUrl)join-event"

    //Twitch
    static var getTwitchVideosAPI : String = "\(baseUrl)twitch-videos"
    

}
