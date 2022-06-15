//
//  Response.swift
//  Services
//
//  Created by Vahe Makaryan on 13.10.21.
//

import Foundation

public struct Response<T: Codable>: Codable {

    let status: Int?
    public let result: T?
    let error: MedupError?
    let log: Log?
    let user: String?
    let dateTime, dateTimeMsecs, duration, dbDuration: String?
    let rdbDuration, waitingTime, nodeID, nodeIDEx: String?
    let queueSize: String?
    let params: [String]?
    let uniqueID: String?

    enum CodingKeys: String, CodingKey {
        case status, result, error, log, user
        case dateTime = "date_time"
        case dateTimeMsecs = "date_time_msecs"
        case duration
        case dbDuration = "db_duration"
        case rdbDuration = "rdb_duration"
        case waitingTime = "waiting_time"
        case nodeID = "node_id"
        case nodeIDEx = "node_id_ex"
        case queueSize = "queue_size"
        case params
        case uniqueID = "unique_id"
    }
}

// MARK: - Log
struct Log: Codable {
    let logs: [String]?
}

// MARK: - Config
enum MedupError: Codable {
    case string(String)
    case errorModel(ErrorResponse)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(ErrorResponse.self) {
            self = .errorModel(x)
            return
        }
        throw DecodingError.typeMismatch(MedupError.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for IDS"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .errorModel(let x):
            try container.encode(x)
        }
    }
}

public struct ErrorResponse: Codable {
    var errorMessage: String?
}
