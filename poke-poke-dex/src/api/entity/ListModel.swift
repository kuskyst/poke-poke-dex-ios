//
//  ListModel.swift
//  poke-poke-dex
//
//  Created by kohsaka on 2022/10/01.
//

import Foundation

struct ListRequest: Decodable {
    var limit: Int = 20
    var offset: Int = 0
}

struct ListResponse: Decodable {
    let results: [Results]
    struct Results: Decodable {
        let name: String
        let url: URL
    }
}
