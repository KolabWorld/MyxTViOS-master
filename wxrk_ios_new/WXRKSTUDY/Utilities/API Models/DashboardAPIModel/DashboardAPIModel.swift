// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let dashboardAPIModel = try? newJSONDecoder().decode(DashboardAPIModel.self, from: jsonData)

import Foundation
import RealmSwift
import SwiftyJSON

// MARK: - DashboardAPIModel
class DashboardAPIModel: Codable {
    let status: Int
    let data: DashboardAPIModelData
    let errors: Errors?

    init(status: Int, data: DashboardAPIModelData, errors: Errors?) {
        self.status = status
        self.data = data
        self.errors = errors
    }
}

// MARK: - DashboardAPIModelData
class DashboardAPIModelData: Codable {
    let message: String?
       let data: DataData

    init(message: String?, data: DataData) {
        self.message = message
        self.data = data
    }
}

// MARK: - DataData
class DataData: Codable {
    let totalBalance: String?
    let dayWiseSummary: DayWiseSummary?
    let iosAppPerformace: [DayWiseSummary]?
    let banners: [DataBanner]
    let offers: [DataOffer]
    let events: [Event]
    let user: User

    
    enum CodingKeys: String, CodingKey {
        case totalBalance = "total_balance"
        case dayWiseSummary = "day_wise_summary"
        case iosAppPerformace = "ios_app_performace"
        case offers = "offers"
        case banners, events, user
    }

    init(totalBalance: String?, dayWiseSummary: DayWiseSummary?, iosAppPerformace: [DayWiseSummary], banners: [DataBanner], offers: [DataOffer], events: [Event], user: User) {
        self.totalBalance = totalBalance
        self.dayWiseSummary = dayWiseSummary
        self.iosAppPerformace = iosAppPerformace
        self.banners = banners
        self.offers = offers
        self.events = events
        self.user = user
    }
}

// MARK: - DayWiseSummary
class DayWiseSummary: Codable {
    let id: Int
    let userID: String
    let userType, androidUsageLogID, appSummaryLogID, logDate: String?
    let wxrkPerMinute: String?
    let totalAppUsageTime: String?
    let dayTotalTime, dayIdleTime: String?
    let watchTime, timeSaved, timeSavedPercentage, wxrkEarned: String?
    let wxrkSpent, wxrkBalance: String?
    let status: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case userType = "user_type"
        case androidUsageLogID = "android_usage_log_id"
        case appSummaryLogID = "app_summary_log_id"
        case logDate = "log_date"
        case wxrkPerMinute = "wxrk_per_minute"
        case totalAppUsageTime = "total_app_usage_time"
        case dayTotalTime = "day_total_time"
        case dayIdleTime = "day_idle_time"
        case watchTime = "watch_time"
        case timeSaved = "time_saved"
        case timeSavedPercentage = "time_saved_percentage"
        case wxrkEarned = "wxrk_earned"
        case wxrkSpent = "wxrk_spent"
        case wxrkBalance = "wxrk_balance"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    init(id: Int, userID: String, userType: String?, androidUsageLogID: String?, appSummaryLogID: String?, logDate: String?, wxrkPerMinute: String, totalAppUsageTime: String?, dayTotalTime: String?, dayIdleTime: String?, watchTime: String, timeSaved: String, timeSavedPercentage: String, wxrkEarned: String, wxrkSpent: String, wxrkBalance: String, status: String?, createdAt: String, updatedAt: String) {
        self.id = id
        self.userID = userID
        self.userType = userType
        self.androidUsageLogID = androidUsageLogID
        self.appSummaryLogID = appSummaryLogID
        self.logDate = logDate
        self.wxrkPerMinute = wxrkPerMinute
        self.totalAppUsageTime = totalAppUsageTime
        self.dayTotalTime = dayTotalTime
        self.dayIdleTime = dayIdleTime
        self.watchTime = watchTime
        self.timeSaved = timeSaved
        self.timeSavedPercentage = timeSavedPercentage
        self.wxrkEarned = wxrkEarned
        self.wxrkSpent = wxrkSpent
        self.wxrkBalance = wxrkBalance
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

// MARK: - DataBanner
class DataBanner: Codable {
    let id: Int
    let type, name, buttonText: String?
    let buttonLink: String?
    let attachmentType, isAutoPlay, status: String?
    let createdAt, updatedAt: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id, type, name
        case buttonText = "button_text"
        case buttonLink = "button_link"
        case attachmentType = "attachment_type"
        case isAutoPlay = "is_auto_play"
        case status
    
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case image
    }

    init(id: Int, type: String?, name: String?, buttonText: String?, buttonLink: String?, attachmentType: String?, isAutoPlay: String?, status: String?, createdAt: String?, updatedAt: String?, image: String?) {
        self.id = id
        self.type = type
        self.name = name
        self.buttonText = buttonText
        self.buttonLink = buttonLink
        self.attachmentType = attachmentType
        self.isAutoPlay = isAutoPlay
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.image = image
    }
}

// MARK: - Event
class Event: Codable {
    let id: Int
    let eventTypeID: String?
    let name, eventDescription: String?
    let highlights: String?
    let organizer, howToJoin, countryID: String?
    let startDateTime, endDateTime: String?
    let venue: String?
    let companyName, aboutTheCompany: String?
    let status: String?
    let createdAt, updatedAt: String?
    let totalMembers: Int
    let remainingTime: String?
    let thumbnailImage: String?
    let companyLogo: String?
    let banner, sponser: [SponserElement]
   // let countries: [Country]
    let users: [User]
    let alreadyJoined : Int?
    enum CodingKeys: String, CodingKey {
        case id
        case eventTypeID = "event_type_id"
        case name
        case eventDescription = "description"
        case highlights, organizer
        case howToJoin = "how_to_join"
        case countryID = "country_id"
        case startDateTime = "start_date_time"
        case endDateTime = "end_date_time"
        case venue
        case companyName = "company_name"
        case aboutTheCompany = "about_the_company"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case totalMembers = "total_members"
        case remainingTime = "remaining_time"
        case thumbnailImage = "thumbnail_image"
        case companyLogo = "company_logo"
        case banner, sponser,  users //countries,
        case alreadyJoined = "already_joined"
    }

    init(id: Int, eventTypeID: String?, name: String?, eventDescription: String?, highlights: String?, organizer: String?, howToJoin: String?, countryID: String?, startDateTime: String?, endDateTime: String?, venue: String?, companyName: String?, aboutTheCompany: String?, status: String?,  createdAt: String?, updatedAt: String?, totalMembers: Int, remainingTime: String?, thumbnailImage: String?, companyLogo: String?, banner: [SponserElement], sponser: [SponserElement],  users: [User], alreadyJoined: Int?) {
        self.id = id
        self.eventTypeID = eventTypeID
        self.name = name
        self.eventDescription = eventDescription
        self.highlights = highlights
        self.organizer = organizer
        self.howToJoin = howToJoin
        self.countryID = countryID
        self.startDateTime = startDateTime
        self.endDateTime = endDateTime
        self.venue = venue
        self.companyName = companyName
        self.aboutTheCompany = aboutTheCompany
        self.status = status
       
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.totalMembers = totalMembers
        self.remainingTime = remainingTime
        self.thumbnailImage = thumbnailImage
        self.companyLogo = companyLogo
        self.banner = banner
        self.sponser = sponser
        //self.countries = countries
        self.users = users
        self.alreadyJoined = alreadyJoined
    }
}

// MARK: - SponserElement
class SponserElement: Codable {
    let id: Int
    let modelType: String?
    let modelID: String?
    let collectionName: String?
    let name, fileName: String?
    let mimeType: String?
    let disk: String?
    let size: String?
    let manipulations, customProperties, responsiveImages: [JSONAny]
    let orderColumn, createdAt, updatedAt: String?
    let fullURL: String?

    enum CodingKeys: String, CodingKey {
        case id
        case modelType = "model_type"
        case modelID = "model_id"
        case collectionName = "collection_name"
        case name
        case fileName = "file_name"
        case mimeType = "mime_type"
        case disk, size, manipulations
        case customProperties = "custom_properties"
        case responsiveImages = "responsive_images"
        case orderColumn = "order_column"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case fullURL = "full_url"
    }

    init(id: Int, modelType: String?, modelID: String?, collectionName: String?, name: String?, fileName: String?, mimeType: String?, disk: String?, size: String?, manipulations: [JSONAny], customProperties: [JSONAny], responsiveImages: [JSONAny], orderColumn: String?, createdAt: String?, updatedAt: String?, fullURL: String?) {
        self.id = id
        self.modelType = modelType
        self.modelID = modelID
        self.collectionName = collectionName
        self.name = name
        self.fileName = fileName
        self.mimeType = mimeType
        self.disk = disk
        self.size = size
        self.manipulations = manipulations
        self.customProperties = customProperties
        self.responsiveImages = responsiveImages
        self.orderColumn = orderColumn
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.fullURL = fullURL
    }
}

//enum CollectionName: String, Codable {
//    case banners = "banners"
//    case sponsers = "sponsers"
//}
//
//enum Disk: String, Codable {
//    case diskPublic = "public"
//}
//
//enum MIMEType: String, Codable {
//    case imageJPEG = "image/jpeg"
//    case imagePNG = "image/png"
//}
//
//enum ModelType: String, Codable {
//    case appModelsEvent = "App\\Models\\Event"
//    case appModelsOffer = "App\\Models\\Offer"
//}
//
//enum CompanyLogo: Codable {
//    case bool(Bool)
//    case string(String)
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if let x = try? container.decode(Bool.self) {
//            self = .bool(x)
//            return
//        }
//        if let x = try? container.decode(String.self) {
//            self = .string(x)
//            return
//        }
//        throw DecodingError.typeMismatch(CompanyLogo.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for CompanyLogo"))
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        switch self {
//        case .bool(let x):
//            try container.encode(x)
//        case .string(let x):
//            try container.encode(x)
//        }
//    }
//}

// MARK: - Country
class Country: Codable {
    let id: Int
    let name, code, dialCode, status: String?
    let createdAt, updatedAt: String?
    let pivot: CountryPivot

    enum CodingKeys: String, CodingKey {
        case id, name, code
        case dialCode = "dial_code"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pivot
    }

    init(id: Int, name: String?, code: String?, dialCode: String?, status: String?, createdAt: String?, updatedAt: String?, pivot: CountryPivot) {
        self.id = id
        self.name = name
        self.code = code
        self.dialCode = dialCode
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.pivot = pivot
    }
}

// MARK: - CountryPivot
class CountryPivot: Codable {
    let eventID, countryID: String?

    enum CodingKeys: String, CodingKey {
        case eventID = "event_id"
        case countryID = "country_id"
    }

    init(eventID: String?, countryID: String?) {
        self.eventID = eventID
        self.countryID = countryID
    }
}

// MARK: - User
class User: Codable {
    let id: Int
    let name, userName, hasPassword, email: String?
    let isEmailVerified: String?
    let mobile: String?
    let isMobileVerified, twoStepVerification, dateOfBirth: String?
    let gender, maritalStatus, timezone: String?
    let isNewUser, status: String?
    let createdAt, updatedAt: String?
    let profilePic: String?
    let pivot: UserPivot?

    enum CodingKeys: String, CodingKey {
        case id, name
        case userName = "user_name"
        case hasPassword = "has_password"
        case email
        case isEmailVerified = "is_email_verified"
        case mobile
        case isMobileVerified = "is_mobile_verified"
        case twoStepVerification = "two_step_verification"
        case dateOfBirth = "date_of_birth"
        case gender
        case maritalStatus = "marital_status"
        case timezone
        case isNewUser = "is_new_user"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case profilePic = "profile_pic"
        case pivot
    }

    init(id: Int, name: String?, userName: String?, hasPassword: String?, email: String?, isEmailVerified: String?, mobile: String?, isMobileVerified: String?, twoStepVerification: String?, dateOfBirth: String?, gender: String?, maritalStatus: String?, timezone: String?, isNewUser: String?, status: String?,  createdAt: String?, updatedAt: String?, profilePic: String?, pivot: UserPivot?) {
        self.id = id
        self.name = name
        self.userName = userName
        self.hasPassword = hasPassword
        self.email = email
        self.isEmailVerified = isEmailVerified
        self.mobile = mobile
        self.isMobileVerified = isMobileVerified
        self.twoStepVerification = twoStepVerification
        self.dateOfBirth = dateOfBirth
        self.gender = gender
        self.maritalStatus = maritalStatus
        self.timezone = timezone
        self.isNewUser = isNewUser
        self.status = status
      
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.profilePic = profilePic
        self.pivot = pivot
    }
}

// MARK: - User
class UserDB: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name, userName, hasPassword, email: String?
    @objc dynamic var isEmailVerified: String?
    @objc dynamic var mobile: String?
    @objc dynamic var isMobileVerified, twoStepVerification, dateOfBirth: String?
    @objc dynamic var gender, maritalStatus, timezone: String?
    @objc dynamic var isNewUser, status: String?
    @objc dynamic var createdAt, updatedAt: String?
    @objc dynamic var profilePic: String?

    
    convenience required init(withJSON json : JSON) {
        
        self.init()
        self.id = json["id"].intValue
        self.name = json["name"]["id"].stringValue
        self.userName = json["user_name"].stringValue
        self.hasPassword = json["has_password"].stringValue
        self.isEmailVerified = json["is_email_verified"].stringValue
        self.email = json["email"].stringValue

        self.mobile = json["mobile"].stringValue
        self.isMobileVerified = json["is_mobile_verified"].stringValue
        self.twoStepVerification = json["two_step_verification"].stringValue
        self.dateOfBirth = json["date_of_birth"].stringValue
        self.gender = json["gender"].stringValue
        self.maritalStatus = json["marital_status"].stringValue
        self.timezone = json["timezone"].stringValue
        self.isNewUser = json["is_new_user"].stringValue
        self.status = json["status"].stringValue
        self.createdAt = json["created_at"].stringValue
        self.updatedAt = json["updated_at"].stringValue
        self.profilePic = json["profile_pic"].stringValue

    }
}

// MARK: - UserPivot
class UserPivot: Codable {
    let eventID, userID: String?

    enum CodingKeys: String, CodingKey {
        case eventID = "event_id"
        case userID = "user_id"
    }

    init(eventID: String?, userID: String?) {
        self.eventID = eventID
        self.userID = userID
    }
}

// MARK: - DataOffer
class DataOffer: Codable {
//    let id: Int
//    let name, status, createdAt, updatedAt: String?
////    let offers: [OfferOffer]
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, status
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
////        case offers
//    }
//
//    init(id: Int, name: String?, status: String?, createdAt: String?, updatedAt: String?, offers: [OfferOffer]) {
//        self.id = id
//        self.name = name
//        self.status = status
//        self.createdAt = createdAt
//        self.updatedAt = updatedAt
////        self.offers = offers
//    }
    let id: Int
    var isLowStock: String?
    let priceViewID, countryID: String?
    let offerTypeID, offerCategoryID, premiumCategoryID, offerName: String?
    let offerPrice, offerPriceInWxrk, offerPeriod, offerListingPrice, offerListingValue: String?
    let premiumListingPeriod, premiumListingPrice, premiumListingValue, totalValue: String?
    let startDate, stock, lowStock: String?
    let youGet: String?
    let timeToRedeem: String?
    let quantityPerUser: String?
    let shippingCost, highlightOfOffer: String?
    let detailsOfOffer: String?
    let companyName, aboutTheCompany: String?
    let link: String?
    let offerCodeBgColor, offerCodeTextColor, status: String?
    let createdAt, updatedAt, remainingDays: String?
    let companyLogo, thumbnailImage: String?
    let banner: [SponserElement]

    enum CodingKeys: String, CodingKey {
        case id
        case priceViewID = "price_view_id"
        case countryID = "country_id"
        case offerTypeID = "offer_type_id"
        case offerCategoryID = "offer_category_id"
        case premiumCategoryID = "premium_category_id"
        case offerName = "offer_name"
        case offerPrice = "offer_price"
        case offerPriceInWxrk = "offer_price_in_wxrk"
        case offerPeriod = "offer_period"
        case offerListingPrice = "offer_listing_price"
        case offerListingValue = "offer_listing_value"
        case premiumListingPeriod = "premium_listing_period"
        case premiumListingPrice = "premium_listing_price"
        case premiumListingValue = "premium_listing_value"
        case totalValue = "total_value"
        case startDate = "start_date"
        case stock
        case lowStock = "low_stock"
        case isLowStock = "is_low_stock"
        case youGet = "you_get"
        case timeToRedeem = "time_to_redeem"
        case quantityPerUser = "quantity_per_user"
        case shippingCost = "shipping_cost"
        case highlightOfOffer = "highlight_of_offer"
        case detailsOfOffer = "details_of_offer"
        case companyName = "company_name"
        case aboutTheCompany = "about_the_company"
        case link
        case offerCodeBgColor = "offer_code_bg_color"
        case offerCodeTextColor = "offer_code_text_color"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case remainingDays = "remaining_days"
        case companyLogo = "company_logo"
        case thumbnailImage = "thumbnail_image"
        case banner
    }

    init(id: Int, isLowStock: String?, priceViewID: String?, countryID: String?, offerTypeID: String?, offerCategoryID: String?, premiumCategoryID: String?, offerName: String?, offerPrice: String?, offerPriceInWxrk: String? , offerPeriod: String?, offerListingPrice: String?, offerListingValue: String?, premiumListingPeriod: String?, premiumListingPrice: String?, premiumListingValue: String?, totalValue: String?, startDate: String?, stock: String?, lowStock: String?, youGet: String?, timeToRedeem: String?, quantityPerUser: String?, shippingCost: String?, highlightOfOffer: String?, detailsOfOffer: String?, companyName: String?, aboutTheCompany: String?, link: String?, offerCodeBgColor: String?, offerCodeTextColor: String?, status: String?, createdAt: String?, updatedAt: String?, remainingDays: String?, companyLogo: String?, thumbnailImage: String?, banner: [SponserElement]) {
        self.id = id
        self.priceViewID = priceViewID
        self.countryID = countryID
        self.offerTypeID = offerTypeID
        self.offerCategoryID = offerCategoryID
        self.premiumCategoryID = premiumCategoryID
        self.offerName = offerName
        self.offerPrice = offerPrice
        self.offerPriceInWxrk =  offerPriceInWxrk
        self.offerPeriod = offerPeriod
        self.offerListingPrice = offerListingPrice
        self.offerListingValue = offerListingValue
        self.premiumListingPeriod = premiumListingPeriod
        self.premiumListingPrice = premiumListingPrice
        self.premiumListingValue = premiumListingValue
        self.totalValue = totalValue
        self.startDate = startDate
        self.stock = stock
        self.lowStock = lowStock
        self.isLowStock = isLowStock
        self.youGet = youGet
        self.timeToRedeem = timeToRedeem
        self.quantityPerUser = quantityPerUser
        self.shippingCost = shippingCost
        self.highlightOfOffer = highlightOfOffer
        self.detailsOfOffer = detailsOfOffer
        self.companyName = companyName
        self.aboutTheCompany = aboutTheCompany
        self.link = link
        self.offerCodeBgColor = offerCodeBgColor
        self.offerCodeTextColor = offerCodeTextColor
        self.status = status
    
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.remainingDays = remainingDays
        self.companyLogo = companyLogo
        self.thumbnailImage = thumbnailImage
        self.banner = banner
    }
}

// MARK: - OfferOffer
class OfferOffer: Codable {
    let id: Int
    var isLowStock: String?
    let priceViewID, countryID: String?
    let offerTypeID, offerCategoryID, premiumCategoryID, offerName: String?
    let offerPrice, offerPriceInWxrk, offerPeriod, offerListingPrice, offerListingValue: String?
    let premiumListingPeriod, premiumListingPrice, premiumListingValue, totalValue: String?
    let startDate, stock, lowStock: String?
    let youGet: String?
    let timeToRedeem: String?
    let quantityPerUser: String?
    let shippingCost, highlightOfOffer: String?
    let detailsOfOffer: String?
    let companyName, aboutTheCompany: String?
    let link: String?
    let offerCodeBgColor, offerCodeTextColor, status: String?
    let createdAt, updatedAt, remainingDays: String?
    let companyLogo, thumbnailImage: String?
    let banner: [SponserElement]

    enum CodingKeys: String, CodingKey {
        case id
        case priceViewID = "price_view_id"
        case countryID = "country_id"
        case offerTypeID = "offer_type_id"
        case offerCategoryID = "offer_category_id"
        case premiumCategoryID = "premium_category_id"
        case offerName = "offer_name"
        case offerPrice = "offer_price"
        case offerPriceInWxrk = "offer_price_in_wxrk"
        case offerPeriod = "offer_period"
        case offerListingPrice = "offer_listing_price"
        case offerListingValue = "offer_listing_value"
        case premiumListingPeriod = "premium_listing_period"
        case premiumListingPrice = "premium_listing_price"
        case premiumListingValue = "premium_listing_value"
        case totalValue = "total_value"
        case startDate = "start_date"
        case stock
        case lowStock = "low_stock"
        case isLowStock = "is_low_stock"
        case youGet = "you_get"
        case timeToRedeem = "time_to_redeem"
        case quantityPerUser = "quantity_per_user"
        case shippingCost = "shipping_cost"
        case highlightOfOffer = "highlight_of_offer"
        case detailsOfOffer = "details_of_offer"
        case companyName = "company_name"
        case aboutTheCompany = "about_the_company"
        case link
        case offerCodeBgColor = "offer_code_bg_color"
        case offerCodeTextColor = "offer_code_text_color"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case remainingDays = "remaining_days"
        case companyLogo = "company_logo"
        case thumbnailImage = "thumbnail_image"
        case banner
    }

    init(id: Int, isLowStock: String?, priceViewID: String?, countryID: String?, offerTypeID: String?, offerCategoryID: String?, premiumCategoryID: String?, offerName: String?, offerPrice: String?, offerPriceInWxrk: String? , offerPeriod: String?, offerListingPrice: String?, offerListingValue: String?, premiumListingPeriod: String?, premiumListingPrice: String?, premiumListingValue: String?, totalValue: String?, startDate: String?, stock: String?, lowStock: String?, youGet: String?, timeToRedeem: String?, quantityPerUser: String?, shippingCost: String?, highlightOfOffer: String?, detailsOfOffer: String?, companyName: String?, aboutTheCompany: String?, link: String?, offerCodeBgColor: String?, offerCodeTextColor: String?, status: String?, createdAt: String?, updatedAt: String?, remainingDays: String?, companyLogo: String?, thumbnailImage: String?, banner: [SponserElement]) {
        self.id = id
        self.priceViewID = priceViewID
        self.countryID = countryID
        self.offerTypeID = offerTypeID
        self.offerCategoryID = offerCategoryID
        self.premiumCategoryID = premiumCategoryID
        self.offerName = offerName
        self.offerPrice = offerPrice
        self.offerPriceInWxrk =  offerPriceInWxrk
        self.offerPeriod = offerPeriod
        self.offerListingPrice = offerListingPrice
        self.offerListingValue = offerListingValue
        self.premiumListingPeriod = premiumListingPeriod
        self.premiumListingPrice = premiumListingPrice
        self.premiumListingValue = premiumListingValue
        self.totalValue = totalValue
        self.startDate = startDate
        self.stock = stock
        self.lowStock = lowStock
        self.isLowStock = isLowStock
        self.youGet = youGet
        self.timeToRedeem = timeToRedeem
        self.quantityPerUser = quantityPerUser
        self.shippingCost = shippingCost
        self.highlightOfOffer = highlightOfOffer
        self.detailsOfOffer = detailsOfOffer
        self.companyName = companyName
        self.aboutTheCompany = aboutTheCompany
        self.link = link
        self.offerCodeBgColor = offerCodeBgColor
        self.offerCodeTextColor = offerCodeTextColor
        self.status = status
    
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.remainingDays = remainingDays
        self.companyLogo = companyLogo
        self.thumbnailImage = thumbnailImage
        self.banner = banner
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}


class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String?.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String? {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String? {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String? {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
