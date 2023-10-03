//
//  ImageApi.swift
//  poke-poke-dex
//
//  Created by kohsaka on 2022/10/03.
//

import Foundation
import Moya

enum ImageApi {
    case front_default(Int)
    case back_default(Int)
    case front_shiny(Int)
    case back_shiny(Int)
}

extension ImageApi: TargetType {

    var baseURL: URL { return URL(string: "https://raw.githubusercontent.com/POKEAPI/sprites/master/sprites/pokemon/")! }

    var path: String {
        switch self {
            case .front_default(let id): return "\(id).png"
            case .back_default(let id): return "/back/\(id).png"
            case .front_shiny(let id): return "/shiny/\(id).png"
            case .back_shiny(let id): return "/back/shiny/\(id).png"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Moya.Task {
        return .requestPlain
    }

    var headers: [String : String]? {
        return nil
    }

}
