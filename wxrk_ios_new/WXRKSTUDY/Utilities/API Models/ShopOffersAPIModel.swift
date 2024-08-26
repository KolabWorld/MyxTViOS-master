//
//  ShopOffersAPIModel.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 24/08/22.
//

import Foundation

// MARK: - ShopOffersAPIModel
class ShopOffersAPIModel: Codable {
    let status: Int
    let data: ShopOffersAPIModelData
    let errors: Errors?
    init(status: Int, data: ShopOffersAPIModelData, errors: Errors?) {
        self.status = status
        self.data = data
        self.errors = errors

    }
}

// MARK: - ShopOffersAPIModelData
class ShopOffersAPIModelData: Codable {
    let message:String?
    let data: ShopOffersDataData

    init(message:String?, data: ShopOffersDataData) {
        self.message = message
        self.data = data
    }
}

// MARK: - ShopOffersDataData
class ShopOffersDataData: Codable {
    let offers: [Offer]

    init(offers: [Offer]) {
        self.offers = offers
    }
}

// MARK: - Offer
class Offer: Codable {
    let id: Int
    var isLowStock: String?
    let priceViewID, countryID: String?
    let offerTypeID, offerCategoryID, premiumCategoryID, offerName:String?
    let offerPrice,  offerPriceInWxrk, offerPeriod, offerListingPrice, offerListingValue:String?
    let premiumListingPeriod, premiumListingPrice, premiumListingValue, totalValue:String?
    let startDate, stock, lowStock:String?
    let youGet:String?
    let timeToRedeem:String?
    let quantityPerUser:String?
    let shippingCost, highlightOfOffer:String?
    let detailsOfOffer:String?
    let companyName, aboutTheCompany:String?
    let link:String?
    let offerCodeBgColor, offerCodeTextColor:String?
    let status:String?
    let createdAt, updatedAt, remainingDays:String?
    let companyLogo, thumbnailImage:String?
    let banner: [Banner]
    let offerType, offerCategory, premiumCategory: OfferCategory?
    let alreadyJoined : Int?
    enum CodingKeys:String, CodingKey {
        case id
        case priceViewID = "price_view_id"
        case countryID = "country_id"
        case alreadyJoined = "already_joined"
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

    init(id: Int, isLowStock: String?, priceViewID:String?, countryID:String?, offerTypeID:String?, offerCategoryID:String?, premiumCategoryID:String?, offerName:String?, offerPrice:String?,  offerPriceInWxrk: String?, offerPeriod:String?, offerListingPrice:String?, offerListingValue:String?, premiumListingPeriod:String?, premiumListingPrice:String?, premiumListingValue:String?, totalValue:String?, startDate:String?, stock:String?, lowStock:String?, youGet:String?, timeToRedeem:String?, quantityPerUser:String?, shippingCost:String?, highlightOfOffer:String?, detailsOfOffer:String?, companyName:String?, aboutTheCompany:String?, link:String?, offerCodeBgColor:String?, offerCodeTextColor:String?, status:String?,  createdAt:String?, updatedAt:String?, remainingDays:String?, companyLogo:String?, thumbnailImage:String?, banner: [Banner], offerType: OfferCategory?, offerCategory: OfferCategory?, premiumCategory: OfferCategory, alreadyJoined: Int?) {
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
    }
}



