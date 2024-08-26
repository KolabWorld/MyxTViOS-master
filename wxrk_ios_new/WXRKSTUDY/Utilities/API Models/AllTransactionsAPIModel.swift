// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let allTransactionsAPIModel = try? newJSONDecoder().decode(AllTransactionsAPIModel.self, from: jsonData)

import Foundation

// MARK: - AllTransactionsAPIModel
class AllTransactionsAPIModel: Codable {
    let status: Int
    let data: AllTransactionsAPIModelData
    let errors: Errors?
    init(status: Int, data: AllTransactionsAPIModelData, errors: Errors?) {
        self.status = status
        self.data = data
        self.errors = errors

    }
}

// MARK: - AllTransactionsAPIModelData
class AllTransactionsAPIModelData: Codable {
    let message: String
    let data: AllDataData

    init(message: String, data: AllDataData) {
        self.message = message
        self.data = data
    }
}

// MARK: - DataData
class AllDataData: Codable {
    let fromDate, toDate: String
    let transactions: [TopTransaction]

    enum CodingKeys: String, CodingKey {
        case fromDate = "from_date"
        case toDate = "to_date"
        case transactions
    }

    init(fromDate: String, toDate: String, transactions: [TopTransaction]) {
        self.fromDate = fromDate
        self.toDate = toDate
        self.transactions = transactions
    }
}
