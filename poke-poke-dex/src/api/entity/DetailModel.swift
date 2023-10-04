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
    let height: Double
    let weight: Double
    let sprites: Sprites
    let types: [Types]
    let stats: [Stats]
    struct Sprites: Decodable {
        let front_default: URL
        let back_default: URL?
        let front_shiny: URL?
        let back_shiny: URL?
    }
    struct Types: Decodable {
        let type: `Type`
        struct `Type`: Decodable {
            let name: String
        }
    }
    struct Stats: Decodable {
        let base_stat: Int
    }
}

struct SpeciesResponse: Decodable {
    let id: Int
    let egg_groups: [EggGroups]
    let flavor_text_entries: [FlavorTextEntries]
    let genera: [Genera]
    struct EggGroups: Decodable {
        let name: String
    }
    struct FlavorTextEntries: Decodable {
        let flavor_text: String
        let language: Language
        let version: Version
        struct Language: Decodable {
            let name: String
        }
        struct Version: Decodable {
            let name: String
        }
    }
    struct Genera: Decodable {
        let genus: String
        let language: Language
        struct Language: Decodable {
            let name: String
        }
    }
}
