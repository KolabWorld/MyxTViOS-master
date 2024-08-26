import Foundation

// MARK: - LoginAPIModel
class LoginAPIModel: Codable {
    let status: Int
    let data: LoginAPIModelData?
    let errors: Errors?

    init(status: Int, data: LoginAPIModelData, errors: Errors?) {
        self.status = status
        self.data = data
        self.errors = errors
    }
}

// MARK: - LoginAPIModelData
class LoginAPIModelData: Codable {
    let message: String
    let data: LoginDataData
    let accessToken: String

    enum CodingKeys: String, CodingKey {
        case message, data
        case accessToken = "access_token"
    }

    init(message: String, data: LoginDataData, accessToken: String) {
        self.message = message
        self.data = data
        self.accessToken = accessToken
    }
}

// MARK: - LoginDataData
class LoginDataData: Codable {
    let id: Int
    let name: String?
    let userName, hasPassword: String
    let email: String?
    let isEmailVerified: String
    let mobile: String?
    let isMobileVerified, twoStepVerification: String
    let dateOfBirth, gender, maritalStatus, timezone: String?
    let status: String
    let createdAt, updatedAt: String
    let profileImageURL: String?
    let roles: [JSONAny]
    let isNewUser: String?

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
        case timezone, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case profileImageURL = "profile_image_url"
        case isNewUser = "is_new_user"
        case roles
    }

    init(id: Int, name: String, userName: String, hasPassword: String, email: String?, isEmailVerified: String, mobile: String?, isMobileVerified: String, twoStepVerification: String, dateOfBirth: String?, gender: String?, maritalStatus: String?, timezone: String?, status: String,  isNewUser: String,  createdAt: String, updatedAt: String, profileImageURL: String?, roles: [JSONAny]) {
        self.id = id
        self.name = name
        self.isNewUser = isNewUser
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
        self.status = status
      
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.profileImageURL = profileImageURL
        self.roles = roles
    }
}
