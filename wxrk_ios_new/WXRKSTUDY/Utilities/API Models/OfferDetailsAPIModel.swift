// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let offerDetailsAPIModel = try? newJSONDecoder().decode(OfferDetailsAPIModel.self, from: jsonData)

import Foundation

// MARK: - OfferDetailsAPIModel
class OfferDetailsAPIModel: Codable {
    let status: Int?
    let data: OfferDetailsAPIModelData?
    let errors: Errors?
    init(status: Int, data: OfferDetailsAPIModelData, errors: Errors?) {
        self.status = status
        self.data = data
        self.errors = errors

    }
}

// MARK: - OfferDetailsAPIModelData
class OfferDetailsAPIModelData: Codable {
    let message: String?
    let data: ViewDataData?

    init(message: String?, data: ViewDataData) {
        self.message = message
        self.data = data
    }
}

// MARK: - DataData
class ViewDataData: Codable {
    let offer: ViewOffer?

    init(offer: ViewOffer) {
        self.offer = offer
    }
}

// MARK: - Offer
class ViewOffer: Codable {
    let id: Int?
    var isLowStock: String?
    let priceViewID, countryID: String?
    let offerTypeID, offerCategoryID, premiumCategoryID, offerName: String?
    let offerPrice,  offerPriceInWxrk, offerPeriod, offerListingPrice, offerListingValue: String?
    let premiumListingPeriod, premiumListingPrice, premiumListingValue, totalValue: String?
    let startDate, stock, lowStock, offerEndDate: String?
    let youGet: String?
    let timeToRedeem: String?
    let quantityPerUser: String?
    let shippingCost, highlightOfOffer: String?
    let detailsOfOffer: String?
    let companyName, aboutTheCompany, link, offerCodeBgColor: String?
    let offerCodeTextColor: String?
    let status:  String?
    let createdAt, updatedAt, remainingDays: String?
    let companyLogo, thumbnailImage: String?
    let banner: [Banner]
    let offerType, offerCategory, premiumCategory: ViewOfferCategory?
    let promoCodes: [PromoCode]
    let alreadyJoined: Int?
    
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
        case offerEndDate = "offer_end_date"
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
        case offerType = "offer_type"
        case alreadyJoined = "already_joined"
        case offerCategory = "offer_category"
        case premiumCategory = "premium_category"
        case promoCodes = "promo_codes"
    }

    init(id: Int, isLowStock: String?, priceViewID: String?, countryID: String?, offerTypeID: String?, offerCategoryID: String?, premiumCategoryID: String?, offerName: String?, offerPrice: String?,  offerPriceInWxrk: String?, offerPeriod: String?, offerListingPrice: String?, offerListingValue: String?, premiumListingPeriod: String?, premiumListingPrice: String?, premiumListingValue: String?, totalValue: String?, startDate: String?, offerEndDate: String?, stock: String?, lowStock: String?, youGet: String?, timeToRedeem: String?, quantityPerUser: String?, shippingCost: String?, highlightOfOffer: String?, detailsOfOffer: String?, companyName: String?, aboutTheCompany: String?, link: String?, offerCodeBgColor: String?, offerCodeTextColor: String?, status:  String?,  createdAt: String?, updatedAt: String?, remainingDays: String?, companyLogo: String?, thumbnailImage: String?, banner: [Banner], offerType: ViewOfferCategory, offerCategory: ViewOfferCategory, premiumCategory: ViewOfferCategory, promoCodes: [PromoCode], alreadyJoined: Int?) {
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
        self.offerEndDate = offerEndDate
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
        self.alreadyJoined = alreadyJoined
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.remainingDays = remainingDays
        self.companyLogo = companyLogo
        self.thumbnailImage = thumbnailImage
        self.banner = banner
        self.offerType = offerType
        self.offerCategory = offerCategory
        self.premiumCategory = premiumCategory
        self.promoCodes = promoCodes
    }
}

// MARK: - Banner
class Banner: Codable {
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

// MARK: - ViewOfferCategory
class ViewOfferCategory: Codable {
    let id: Int
    let name: String?
    let status:  String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    init(id: Int, name: String?, status:  String?, createdAt: String?, updatedAt: String?) {
        self.id = id
        self.name = name
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}



// MARK: - PromoCode
class PromoCode: Codable {
    let id: Int
    let offerID, promoCode: String?
    let redemptionStatus, redemptionDate: String?
    let status:  String?
   
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case offerID = "offer_id"
        case promoCode = "promo_code"
        case redemptionStatus = "redemption_status"
        case redemptionDate = "redemption_date"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    init(id: Int, offerID: String?, promoCode: String?, redemptionStatus: String?, redemptionDate: String?, status:  String?, createdAt: String?, updatedAt: String?) {
        self.id = id
        self.offerID = offerID
        self.promoCode = promoCode
        self.redemptionStatus = redemptionStatus
        self.redemptionDate = redemptionDate
        self.status = status
       
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}





