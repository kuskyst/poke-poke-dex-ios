//
//  DetailModel.swift
//  poke-poke-dex
//
//  Created by kohsaka on 2022/10/01.
//

import Foundation

struct DetailResponse: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprites
    struct Sprites: Decodable {
        let front_default: URL
        let back_default: URL
        let front_shiny: URL?
        let back_shiny: URL?
    }
}
