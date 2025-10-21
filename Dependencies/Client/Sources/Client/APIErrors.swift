//
//  APIErrors.swift
//  NBAService
//
//  Created by Sérgio César Lira Júnior on 17/10/25.
//

import Foundation
public enum APIError: LocalizedError {
    case badRequest
    case unauthorized
    case notFound
    case serverError
    case decodingError
    case invalidURL
    case unknown

    var localizedDescription: String {
        switch self {
        case .badRequest:
            return "Bad Request"
        case .unauthorized:
            return "Unauthorized"
        case .notFound:
            return "Not Found"
        case .serverError:
            return "Server Error"
        case .decodingError:
            return "Decoding Error"
        case .invalidURL:
            return "Invalid URL"
        case .unknown:
            return "Unknown Error"
        }
    }
}
