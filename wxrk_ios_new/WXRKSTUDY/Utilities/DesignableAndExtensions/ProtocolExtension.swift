//
//  ProtocolExtension.swift
//  WXRKSTUDY
//
//  Created by Karamjeet Singh on 14/08/22.
//

import Foundation
protocol JsonEncoding where Self: Encodable { }

extension JsonEncoding {
    func encode(using encoder: JSONEncoder) throws -> Data {
        try encoder.encode(self)
    }
}

extension Dictionary where Value == JsonEncoding {
    func encode(using encoder: JSONEncoder) throws -> [Key: String] {
        try compactMapValues {
            try String(data: $0.encode(using: encoder), encoding: .utf8)
        }
    }
}

extension String: JsonEncoding { }
extension Int: JsonEncoding { }

