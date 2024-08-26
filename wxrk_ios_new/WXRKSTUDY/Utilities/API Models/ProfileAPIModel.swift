//
//  ProfileAPIModel.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 17/08/22.
//

import Foundation

import Foundation

// MARK: - ProfileAPIModel
class ProfileAPIModel: Codable {
    let status: Int
    let data: ProfileAPIModelData
    let errors: Errors?

    init(status: Int, data: ProfileAPIModelData, errors: Errors?) {
        self.status = status
        self.data = data
        self.errors = errors

    }
   
}

// MARK: - ProfileAPIModelData
class ProfileAPIModelData: Codable {
    let message: String?
    let data: ProfileDataData

    init(message: String, data: ProfileDataData) {
        self.message = message
        self.data = data
    }
}

// MARK: - DataData
class ProfileDataData: Codable {
    let user: ProfileUser

    init(user: ProfileUser) {
        self.user = user
    }
}

// MARK: - User
class ProfileUser: Codable {
    let id: Int
    let name, userName, hasPassword, email: String?
    let isEmailVerified: String?
    let mobile: String?
    let isMobileVerified, twoStepVerification, dateOfBirth: String?
    let gender, maritalStatus, timezone: String?
    let isNewUser: Int
    let status: String?
    let createdAt, updatedAt: String?
    let profileImageURL: String?
    let profilePic: String?
    let roles: [String?]

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
        case roles
    }

    init(id: Int, name: String?, userName: String?, hasPassword: String?, email: String?, isEmailVerified: String?, mobile: String?, isMobileVerified: String?, twoStepVerification: String?, dateOfBirth: String?, gender: String?, maritalStatus: String?, timezone: String?, isNewUser: Int, status: String?,  createdAt: String?, updatedAt: String?, profileImageURL: String?, profilePic: String, roles: [String?]) {
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
        self.roles = roles
    }
}
