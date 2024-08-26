//
//  CustomErrorType.swift
//  WXRKSTUDY
//
//  Created by Karamjeet Singh on 21/11/22.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let customErrorType = try? newJSONDecoder().decode(CustomErrorType.self, from: jsonData)

import Foundation

// MARK: - CustomErrorType
class CustomErrorType: Codable {
    let status: Int
    let data: JSONNull?
    let errors: Errors

    init(status: Int, data: JSONNull?, errors: Errors) {
        self.status = status
        self.data = data
        self.errors = errors
    }
}

// MARK: - Errors
class Errors: Codable {
    let message: String

    init(message: String) {
        self.message = message
    }
}

