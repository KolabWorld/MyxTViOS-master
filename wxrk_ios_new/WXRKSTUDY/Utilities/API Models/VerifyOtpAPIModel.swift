//
//  VerifyOtpAPIModel.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 17/08/22.
//

import Foundation
// MARK: - VerifyOtpAPIModel
class VerifyOtpAPIModel: Codable {
    let status: Int
    let data: VerifyOtpAPIModelData
    let errors: Errors?

    init(status: Int, data: VerifyOtpAPIModelData, errors: Errors?) {
        self.status = status
        self.data = data
        self.errors = errors

    }
}

// MARK: - VerifyOtpAPIModelData
class VerifyOtpAPIModelData: Codable {
    let message: String
    let data: VerifyOtpDataData

    init(message: String, data: VerifyOtpDataData) {
        self.message = message
        self.data = data
    }
}

// MARK: - DataData
class VerifyOtpDataData: Codable {
    let user: VerifyOtpUser

    init(user: VerifyOtpUser) {
        self.user = user
    }
}

// MARK: - User
class VerifyOtpUser: Codable {
    let id: Int
    let name: String?
    let userName, hasPassword, email, isEmailVerified: String
    let mobile, isMobileVerified, twoStepVerification: String
    let dateOfBirth, gender, maritalStatus, timezone: String?
    let isNewUser, status: String
    let createdAt, updatedAt: String
    let profileImageURL: String?
    let profilePic: String?

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
        case profileImageURL = "profile_image_url"
        case profilePic = "profile_pic"
    }

    init(id: Int, name: String?, userName: String, hasPassword: String, email: String, isEmailVerified: String, mobile: String, isMobileVerified: String, twoStepVerification: String, dateOfBirth: String?, gender: String?, maritalStatus: String?, timezone: String?, isNewUser: String, status: String,  createdAt: String, updatedAt: String, profileImageURL: String?, profilePic: String?) {
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
        self.profileImageURL = profileImageURL
        self.profilePic = profilePic
    }
}
