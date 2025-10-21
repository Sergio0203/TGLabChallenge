//
//  ClientProtocol.swift
//  NBAService
//
//  Created by Sérgio César Lira Júnior on 17/10/25.
//

public protocol ClientProtocol {
    func request<T: Decodable>(_ endPoint: APIEndpointProtocol) async throws -> T
}
