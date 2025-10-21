//
//  APIEndpointProtocol.swift
//  NBAService
//
//  Created by Sérgio César Lira Júnior on 17/10/25.
//
import Foundation

public protocol APIEndpointProtocol {
    var baseUrl: BaseUrls { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var parameters: [String: Any] { get }
    var query: [String: String] { get }
}


public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}
