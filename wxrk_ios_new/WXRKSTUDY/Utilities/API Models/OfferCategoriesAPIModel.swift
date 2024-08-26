//
//  OfferCategoriesAPIModel.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 18/08/22.
//

import Foundation

// MARK: - OfferCategoriesAPIModel
class OfferCategoriesAPIModel: Codable {
    let status: Int?
    let data: OfferCategoriesAPIModelData?
    let errors: Errors?
    init(status: Int, data: OfferCategoriesAPIModelData, errors: Errors?) {
        self.status = status
        self.data = data
        self.errors = errors

    }
}

// MARK: - OfferCategoriesAPIModelData
class OfferCategoriesAPIModelData: Codable {
    let message: String?
    let data: OfferCategoriesDataData?

    init(message: String, data: OfferCategoriesDataData) {
        self.message = message
        self.data = data
    }
}

// MARK: - DataData
class OfferCategoriesDataData: Codable {
    let offerCategories: [OfferCategory]?

    enum CodingKeys: String, CodingKey {
        case offerCategories = "offer_categories"
    }

    init(offerCategories: [OfferCategory]) {
        self.offerCategories = offerCategories
    }
}

// MARK: - OfferCategory
class OfferCategory: Codable {
    let id: Int?
    let name, status, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    init(id: Int, name: String, status: String, createdAt: String, updatedAt: String) {
        self.id = id
        self.name = name
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
