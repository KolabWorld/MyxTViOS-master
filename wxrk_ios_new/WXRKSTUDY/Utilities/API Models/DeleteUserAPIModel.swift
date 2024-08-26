//
//  DeleteUserAPIModel.swift
//  WXRKSTUDY
//
//  Created by Karamjeet Singh on 07/01/23.
//

import Foundation

// MARK: - DeleteUserAPIModel
class DeleteUserAPIModel: Codable {
    let status: Int
    let data: DeleteDataClass
    let errors: Errors?

    init(status: Int, data: DeleteDataClass, errors: Errors?) {
        self.status = status
        self.data = data
        self.errors = errors

    }
}

// MARK: - DataClass
class DeleteDataClass: Codable {
    let message: String

    init(message: String) {
        self.message = message
    }
}
