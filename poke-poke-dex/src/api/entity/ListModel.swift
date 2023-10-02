//
//  ListModel.swift
//  poke-poke-dex
//
//  Created by kohsaka on 2022/10/01.
//

import Foundation

struct ListRequest: Codable {
    let limit: Int
    let offset: Int
}

struct ListResponse: Decodable {
    let results: [Results]
    struct Results: Decodable {
        let name: String
        let url: URL
    }
}
