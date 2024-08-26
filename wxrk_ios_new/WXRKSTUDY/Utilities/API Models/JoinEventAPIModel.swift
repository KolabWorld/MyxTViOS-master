//
//  JoinEventAPIModel.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 01/09/22.
//

import Foundation

// MARK: - JoinEventAPIModel
class JoinEventAPIModel: Codable {
    let status: Int
    let data: DataClass
    let errors: Errors?
    init(status: Int, data: DataClass, errors: Errors?) {
        self.status = status
        self.data = data
        self.errors = errors

    }
}

// MARK: - DataClass
class DataClass: Codable {
    let message, data: String

    init(message: String, data: String) {
        self.message = message
        self.data = data
    }
}
