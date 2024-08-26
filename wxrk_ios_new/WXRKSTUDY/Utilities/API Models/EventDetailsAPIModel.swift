// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let eventDetailsAPIModel = try? newJSONDecoder().decode(EventDetailsAPIModel.self, from: jsonData)

import Foundation

// MARK: - EventDetailsAPIModel
class EventDetailsAPIModel: Codable {
    let status: Int
    let data: EventDetailsAPIModelData
    let errors: Errors?
    init(status: Int, data: EventDetailsAPIModelData, errors: Errors?) {
        self.status = status
        self.data = data
        self.errors = errors

    }
}

// MARK: - EventDetailsAPIModelData
class EventDetailsAPIModelData: Codable {
    let message: String?
    let data: DataEventDetails

    init(message: String?, data: DataEventDetails) {
        self.message = message
        self.data = data
    }
}

// MARK: - DataEventDetails
class DataEventDetails: Codable {
    let event: EventEventDetails

    init(event: EventEventDetails) {
        self.event = event
    }
}

// MARK: - EventEventDetails
class EventEventDetails: Codable {
    let id: Int
    let eventTypeID: String?
    let name, eventDescription, eventHost: String?
    let highlights, organizer, howToJoin, countryID: String?
    let startDateTime, endDateTime: String?
    let venue: String?
    let companyName, aboutTheCompany, status: String?
    let createdAt, updatedAt: String?
    let totalMembers: Int
    let remainingTime: String?
    let thumbnailImage, companyLogo: String?
    let banner : [BannerEventDetails]
    let sponser : [SponserEventDetails]
    let countries: [CountryEventDetails]
    let users: [UserEventDetails]

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
        case eventHost = "event_host"
        case companyLogo = "company_logo"
        case banner, countries, users
        case sponser
    }

    init(id: Int, eventTypeID: String?, name: String?, eventHost: String?, eventDescription: String?, highlights: String?, organizer: String?, howToJoin: String?, countryID: String?, startDateTime: String?, endDateTime: String?, venue: String?, companyName: String?, aboutTheCompany: String?, status: String?,  createdAt: String?, updatedAt: String?, totalMembers: Int, remainingTime: String?, thumbnailImage: String?, companyLogo: String?, banner: [BannerEventDetails], sponser: [SponserEventDetails], countries: [CountryEventDetails], users: [UserEventDetails]) {
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
        self.countries = countries
        self.users = users
        self.eventHost = eventHost
    }
}

// MARK: - SponserEventDetails
class SponserEventDetails: Codable {
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
// MARK: - BannerEventDetails
class BannerEventDetails: Codable {
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

// MARK: - CountryEventDetails
class CountryEventDetails: Codable {
    let id: Int
    let name, code, dialCode, status: String?
    let createdAt, updatedAt: String?
    let pivot: CountryPivotEventDetails

    enum CodingKeys: String, CodingKey {
        case id, name, code
        case dialCode = "dial_code"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pivot
    }

    init(id: Int, name: String?, code: String?, dialCode: String?, status: String?, createdAt: String?, updatedAt: String?, pivot: CountryPivotEventDetails) {
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

// MARK: - CountryPivotEventDetails
class CountryPivotEventDetails: Codable {
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

// MARK: - UserEventDetails
class UserEventDetails: Codable {
    let id: Int
    let name: String?
    let userName, hasPassword, email, isEmailVerified: String?
    let mobile, isMobileVerified, twoStepVerification: String?
    let dateOfBirth, gender, maritalStatus, timezone: String?
    let isNewUser: String?
    let countryID, currencyID: String?
    let status: String?
    let createdAt, updatedAt, profilePic: String?
    let pivot: UserPivotEventDetails

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
        case countryID = "country_id"
        case currencyID = "currency_id"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case profilePic = "profile_pic"
        case pivot
    }

    init(id: Int, name: String?, userName: String?, hasPassword: String?, email: String?, isEmailVerified: String?, mobile: String?, isMobileVerified: String?, twoStepVerification: String?, dateOfBirth: String?, gender: String?, maritalStatus: String?, timezone: String?, isNewUser: String?, countryID: String?, currencyID: String?, status: String?, createdAt: String?, updatedAt: String?, profilePic: String?, pivot: UserPivotEventDetails) {
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
        self.countryID = countryID
        self.currencyID = currencyID
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.profilePic = profilePic
        self.pivot = pivot
    }
}

// MARK: - UserPivotEventDetails
class UserPivotEventDetails: Codable {
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

