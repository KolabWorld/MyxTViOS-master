// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topTransactionsAPIModel = try? newJSONDecoder().decode(TopTransactionsAPIModel.self, from: jsonData)

import Foundation

// MARK: - TopTransactionsAPIModel
class TopTransactionsAPIModel: Codable {
    let status: Int
    let data: TopTransactionsAPIModelData
    let errors: Errors?
    init(status: Int, data: TopTransactionsAPIModelData, errors: Errors?) {
        self.status = status
        self.data = data
        self.errors = errors

    }
}

// MARK: - TopTransactionsAPIModelData
class TopTransactionsAPIModelData: Codable {
    let message: String?
    let data: TopDataData

    init(message: String?, data: TopDataData) {
        self.message = message
        self.data = data
    }
}

// MARK: - DataData
class TopDataData: Codable {
    let transactions: [TopTransaction]

    init(transactions: [TopTransaction]) {
        self.transactions = transactions
    }
}

// MARK: - Transaction
class TopTransaction: Codable {
    let id: Int
    let offerID: String?
    let userID, type, wxrkBalance, appUsageTime: String?
    let idleTime, watchTime, status, createdAt: String?
    let updatedAt: String?
    let user: User
    let offer: TopOffer?

    enum CodingKeys: String, CodingKey {
        case id
        case offerID = "offer_id"
        case userID = "user_id"
        case type
        case wxrkBalance = "wxrk_balance"
        case appUsageTime = "app_usage_time"
        case idleTime = "idle_time"
        case watchTime = "watch_time"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case user, offer
    }

    init(id: Int, offerID: String?, userID: String, type: String, wxrkBalance: String, appUsageTime: String, idleTime: String, watchTime: String?, status: String, createdAt: String, updatedAt: String, user: User, offer: TopOffer) {
        self.id = id
        self.offerID = offerID
        self.userID = userID
        self.type = type
        self.wxrkBalance = wxrkBalance
        self.appUsageTime = appUsageTime
        self.idleTime = idleTime
        self.watchTime = watchTime
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.user = user
        self.offer = offer
    }
}
// MARK: - Offer
class TopOffer: Codable {
    let id: Int
    var isLowStock: String?
    let priceViewID, countryID: String?
    let offerTypeID, offerCategoryID, premiumCategoryID, offerName: String?
    let offerPrice,  offerPriceInWxrk, offerPeriod, offerListingPrice, offerListingValue: String?
    let premiumListingPeriod, premiumListingPrice, premiumListingValue, totalValue: String?
    let startDate, stock, lowStock: String?
    let youGet: String??
    let timeToRedeem: String?
    let quantityPerUser: String??
    let shippingCost, highlightOfOffer: String?
    let detailsOfOffer: String??
    let companyName, aboutTheCompany: String?
    let link: String?
    let offerCodeBgColor, offerCodeTextColor, status: String?
    let createdAt, updatedAt, remainingDays: String?
    let companyLogo, thumbnailImage: String?
    let banner: [TopBanner]

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

    init(id: Int, isLowStock: String?, priceViewID: String?, countryID: String?, offerTypeID: String?, offerCategoryID: String?, premiumCategoryID: String?, offerName: String?, offerPrice: String?,  offerPriceInWxrk: String?, offerPeriod: String?, offerListingPrice: String?, offerListingValue: String?, premiumListingPeriod: String?, premiumListingPrice: String?, premiumListingValue: String?, totalValue: String?, startDate: String?, stock: String?, lowStock: String?, youGet: String??, timeToRedeem: String?, quantityPerUser: String??, shippingCost: String?, highlightOfOffer: String?, detailsOfOffer: String??, companyName: String?, aboutTheCompany: String?, link: String?, offerCodeBgColor: String?, offerCodeTextColor: String?, status: String?, createdAt: String?, updatedAt: String?, remainingDays: String?, companyLogo: String?, thumbnailImage: String?, banner: [TopBanner]) {
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

// MARK: - Banner
class TopBanner: Codable {
    let id: Int
    let modelType, modelID, collectionName, name: String?
    let fileName, mimeType, disk, size: String?
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
