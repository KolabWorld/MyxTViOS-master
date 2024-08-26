// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let buyNowOfferAPIModel = try? newJSONDecoder().decode(BuyNowOfferAPIModel.self, from: jsonData)

import Foundation

// MARK: - BuyNowOfferAPIModel
class BuyNowOfferAPIModel: Codable {
    let status: Int
    let data: BuyDataClass?
    let errors: Errors?

    init(status: Int, data: BuyDataClass, errors: Errors) {
        self.status = status
        self.data = data
        self.errors = errors

    }
}


// MARK: - DataClass
class BuyDataClass: Codable {
    let message: String?
    let promoCode: BuyPromoCode
    let offer: BuyOffer
    let order: BuyOrder

    enum CodingKeys: String, CodingKey {
        case message
        case promoCode = "promo_code"
        case offer, order
    }

    init(message: String?, promoCode: BuyPromoCode, offer: BuyOffer, order: BuyOrder) {
        self.message = message
        self.promoCode = promoCode
        self.offer = offer
        self.order = order
    }
}

// MARK: - Offer
class BuyOffer: Codable {
    let id: Int
    var isLowStock: String?
    let priceViewID, countryID: String?
    let offerTypeID, offerCategoryID, premiumCategoryID, offerName: String?
    let offerPrice,  offerPriceInWxrk, offerPeriod, offerListingPrice, offerListingValue: String?
    let premiumListingPeriod, premiumListingPrice, premiumListingValue, totalValue: String?
    let startDate, stock, lowStock: String?
    let youGet: String?
    let timeToRedeem: String?
    let quantityPerUser: String?
    let shippingCost, highlightOfOffer: String?
    let detailsOfOffer: String?
    let companyName, aboutTheCompany, link: String?
    let offerCodeBgColor, offerCodeTextColor: String?
    let status: String?
    let createdAt, updatedAt, remainingDays: String?
    let companyLogo, thumbnailImage: String?
    let banner: [BuyBanner]
    let offerType, offerCategory, premiumCategory: BuyOfferCategory?

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
        case offerType = "offer_type"
        case offerCategory = "offer_category"
        case premiumCategory = "premium_category"
    }

    init(id: Int, isLowStock: String?, priceViewID: String?, countryID: String?, offerTypeID: String?, offerCategoryID: String?, premiumCategoryID: String?, offerName: String?, offerPrice: String?,  offerPriceInWxrk: String?, offerPeriod: String?, offerListingPrice: String?, offerListingValue: String?, premiumListingPeriod: String?, premiumListingPrice: String?, premiumListingValue: String?, totalValue: String?, startDate: String?, stock: String?, lowStock: String?, youGet: String?, timeToRedeem: String?, quantityPerUser: String?, shippingCost: String?, highlightOfOffer: String?, detailsOfOffer: String?, companyName: String?, aboutTheCompany: String?, link: String?, offerCodeBgColor: String?, offerCodeTextColor: String?, status: String?,  createdAt: String?, updatedAt: String?, remainingDays: String?, companyLogo: String?, thumbnailImage: String?, banner: [BuyBanner], offerType: BuyOfferCategory?, offerCategory: BuyOfferCategory?, premiumCategory: BuyOfferCategory?) {
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
        self.offerType = offerType
        self.offerCategory = offerCategory
        self.premiumCategory = premiumCategory
    }
}

// MARK: - Banner
class BuyBanner: Codable {
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

// MARK: - OfferCategory
class BuyOfferCategory: Codable {
    let id: Int
    let name, status, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    init(id: Int, name: String?, status: String?, createdAt: String?, updatedAt: String?) {
        self.id = id
        self.name = name
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

// MARK: - Order
class BuyOrder: Codable {
    let orderNumber: String?
    let offerID: String?
    let offerName, offerPrice,  offerPriceInWxrk, offerPromoCode, promoCodeRedemptionStatus: String?
    let promoCodeRedemptionDate, offerType, offerCategory, offerPremiumCategory: String?
    let timeToRedeem, highlightOfOffer: String?
    let detailsOfOffer: String?
    let link: String?
    let userID: String?
    let customerName: String?
    let customerMobile, customerEmail, customerCountry, adminID: String?
    let vendorName, vendorMobile, vendorEmail, vendorCountry: String?
    let vendorCategory, vendorState, vendorCity, vendorAddress: String?
    let vendorPostalCode, status: String?
    let updatedAt, createdAt: String?
    let id: Int
    let remainingHours, endTime: String?

    enum CodingKeys: String, CodingKey {
        case orderNumber = "order_number"
        case offerID = "offer_id"
        case offerName = "offer_name"
        case offerPrice = "offer_price"
        case offerPriceInWxrk = "offer_price_in_wxrk"
        case offerPromoCode = "offer_promo_code"
        case promoCodeRedemptionStatus = "promo_code_redemption_status"
        case promoCodeRedemptionDate = "promo_code_redemption_date"
        case offerType = "offer_type"
        case offerCategory = "offer_category"
        case offerPremiumCategory = "offer_premium_category"
        case timeToRedeem = "time_to_redeem"
        case highlightOfOffer = "highlight_of_offer"
        case detailsOfOffer = "details_of_offer"
        case link
        case userID = "user_id"
        case customerName = "customer_name"
        case customerMobile = "customer_mobile"
        case customerEmail = "customer_email"
        case customerCountry = "customer_country"
        case adminID = "admin_id"
        case vendorName = "vendor_name"
        case vendorMobile = "vendor_mobile"
        case vendorEmail = "vendor_email"
        case vendorCountry = "vendor_country"
        case vendorCategory = "vendor_category"
        case vendorState = "vendor_state"
        case vendorCity = "vendor_city"
        case vendorAddress = "vendor_address"
        case vendorPostalCode = "vendor_postal_code"
        case status
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
        case remainingHours = "remaining_hours"
        case endTime = "end_time"
    }

    init(orderNumber: String?, offerID: String?, offerName: String?, offerPrice: String?,  offerPriceInWxrk: String?, offerPromoCode: String?, promoCodeRedemptionStatus: String?, promoCodeRedemptionDate: String?, offerType: String?, offerCategory: String?, offerPremiumCategory: String?, timeToRedeem: String?, highlightOfOffer: String?, detailsOfOffer: String?, link: String?, userID: String?, customerName: String?, customerMobile: String?, customerEmail: String?, customerCountry: String?, adminID: String?, vendorName: String?, vendorMobile: String?, vendorEmail: String?, vendorCountry: String?, vendorCategory: String?, vendorState: String?, vendorCity: String?, vendorAddress: String?, vendorPostalCode: String?, status: String?, updatedAt: String?, createdAt: String?, id: Int, remainingHours: String?, endTime: String?) {
        self.orderNumber = orderNumber
        self.offerID = offerID
        self.offerName = offerName
        self.offerPrice = offerPrice
        self.offerPriceInWxrk =  offerPriceInWxrk
        self.offerPromoCode = offerPromoCode
        self.promoCodeRedemptionStatus = promoCodeRedemptionStatus
        self.promoCodeRedemptionDate = promoCodeRedemptionDate
        self.offerType = offerType
        self.offerCategory = offerCategory
        self.offerPremiumCategory = offerPremiumCategory
        self.timeToRedeem = timeToRedeem
        self.highlightOfOffer = highlightOfOffer
        self.detailsOfOffer = detailsOfOffer
        self.link = link
        self.userID = userID
        self.customerName = customerName
        self.customerMobile = customerMobile
        self.customerEmail = customerEmail
        self.customerCountry = customerCountry
        self.adminID = adminID
        self.vendorName = vendorName
        self.vendorMobile = vendorMobile
        self.vendorEmail = vendorEmail
        self.vendorCountry = vendorCountry
        self.vendorCategory = vendorCategory
        self.vendorState = vendorState
        self.vendorCity = vendorCity
        self.vendorAddress = vendorAddress
        self.vendorPostalCode = vendorPostalCode
        self.status = status
        self.updatedAt = updatedAt
        self.createdAt = createdAt
        self.id = id
        self.remainingHours = remainingHours
        self.endTime = endTime
    }
}

// MARK: - PromoCode
class BuyPromoCode: Codable {
    let id: Int
    let offerID, promoCode: String?
    let redemptionStatus, redemptionDate: String?
    let status: String?
    let createdAt, updatedAt: String?
    let offer: BuyOffer

    enum CodingKeys: String, CodingKey {
        case id
        case offerID = "offer_id"
        case promoCode = "promo_code"
        case redemptionStatus = "redemption_status"
        case redemptionDate = "redemption_date"
        case status
      
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case offer
    }

    init(id: Int, offerID: String?, promoCode: String?, redemptionStatus: String?, redemptionDate: String?, status: String?, createdAt: String?, updatedAt: String?, offer: BuyOffer) {
        self.id = id
        self.offerID = offerID
        self.promoCode = promoCode
        self.redemptionStatus = redemptionStatus
        self.redemptionDate = redemptionDate
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.offer = offer
    }
}




