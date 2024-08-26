import Foundation

// MARK: - SendOtpAPIModel
class SendOtpAPIModel: Codable {
    let status: Int
    let data: SendOtpAPIModelData
    let errors: Errors?

    init(status: Int, data: SendOtpAPIModelData, errors: Errors?) {
        self.status = status
        self.data = data
        self.errors = errors

    }
}

// MARK: - SendOtpAPIModelData
class SendOtpAPIModelData: Codable {
    let message: String
    let data: OTPDataData

    init(message: String, data: OTPDataData) {
        self.message = message
        self.data = data
    }
}

// MARK: - DataData
class OTPDataData: Codable {
    let user: User

    init(user: User) {
        self.user = user
    }
}


