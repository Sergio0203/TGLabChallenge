//
//  APIResponse.swift
//  NBAService
//
//  Created by Sérgio César Lira Júnior on 19/10/25.
//

struct APIResponse<T: Codable>: Codable {
    let data: T
}
