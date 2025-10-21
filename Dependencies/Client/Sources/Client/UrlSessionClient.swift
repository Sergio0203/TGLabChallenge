//
//  UrlSessionClient.swift
//  NBAService
//
//  Created by Sérgio César Lira Júnior on 17/10/25.
//

import Foundation

public final class UrlSessionClient: ClientProtocol {
    public init() {}
    public func request<T>(_ endPoint: APIEndpointProtocol) async throws -> T where T : Decodable {

        guard var url = URL(string: endPoint.baseUrl.rawValue) else {
            throw APIError.invalidURL
        }
        url.append(component: endPoint.path)
        endPoint.query.forEach { key, value in
            url.append(queryItems: [.init(name: key, value: String(value))])
        }

        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        endPoint.headers.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        let retryDelay: UInt64 = 10_000_000_000
        while true {
            do {
                let (data, response) = try await URLSession.shared.data(for: request)

                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.unknown
                }

                return try handleHTTPResponse(httpResponse, data: data)

            } catch APIError.timeRequestLimit {
                try await Task.sleep(nanoseconds: retryDelay)
            } catch {
                throw error
            }
        }
    }

    private func handleHTTPResponse<T: Decodable>(_ response: HTTPURLResponse, data: Data) throws -> T {
        switch response.statusCode {
        case 200...299:
            return try decodeObject(data)
        case 400:
            throw APIError.badRequest
        case 401:
            throw APIError.unauthorized
        case 404:
            throw APIError.notFound
        case 429:
            throw APIError.timeRequestLimit
        case 500...599:
            throw APIError.serverError
        default:
            throw APIError.unknown
        }
    }

    private func decodeObject<T: Decodable>(_ data: Data) throws -> T {
        do {
            let decodedObject: T = try JSONDecoder().decode(T.self, from: data)
            return decodedObject
        } catch {
            throw APIError.decodingError
        }
    }

}
