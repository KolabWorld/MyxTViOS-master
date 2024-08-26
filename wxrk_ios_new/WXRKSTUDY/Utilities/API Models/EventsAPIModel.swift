//
//  EventsAPIModel.swift
//  WXRKSTUDY
//
//  Created by D4d developer on 29/08/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let eventsAPIModel = try? newJSONDecoder().decode(EventsAPIModel.self, from: jsonData)

import Foundation

// MARK: - EventsAPIModel
class EventsAPIModel: Codable {
    let status: Int
    let data: EventsAPIModelData
    let errors: Errors?
    init(status: Int, data: EventsAPIModelData, errors: Errors?) {
        self.status = status
        self.data = data
        self.errors = errors

    }
}

// MARK: - EventsAPIModelData
class EventsAPIModelData: Codable {
    let message: String
    let data: EventDataData

    init(message: String, data: EventDataData) {
        self.message = message
        self.data = data
    }
}

// MARK: - DataData
class EventDataData: Codable {
    let events: [Event]

    init(events: [Event]) {
        self.events = events
    }
}

