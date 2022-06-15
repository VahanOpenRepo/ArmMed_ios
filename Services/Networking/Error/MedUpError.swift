//
//  MedUpError.swift
//  Services
//
//  Created by Hrant on 09.05.21.
//

import Foundation

public enum MedUpError: Error {
    case unexpectedError(String)
    case internalError(String)
    case noData
    case networkError(code: ResponseCodes, message: String?)
}

public enum ResponseCodes: Int {
    case clientError = 400
    case unauthorized = 401
    case permissionDenied = 403
    case notFound = 404
    case timeOut = 408
    case internalError = 500
    case serverError = 501
    case unavailable = 503
    case noInternet = 2
    case unknown = 0

    public func message() -> String {
        var message = "Something went wrong"
        switch self {
        case .clientError:
            message = "Client error - bad request"
        case .unauthorized:
            message = "It looks like your email or password is misspelled."
        case .permissionDenied:
            message = "Permission denied"
        case .notFound:
            message = "The requested resource could not be found"
        case .timeOut:
            message = "Request Timeout"
        case .internalError:
            message = "Internal Server Error"
        case .serverError:
            message = "Server Error - not recognize the request method"
        case .unavailable:
            message = "The server is currently unavailable"
        case .unknown:
            message = "Something went wrong"
        case .noInternet:
            message = "No internet connection"
        }

        return message
    }
}
