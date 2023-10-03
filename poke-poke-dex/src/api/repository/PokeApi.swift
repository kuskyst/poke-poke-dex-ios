//
//  PokeApi.swift
//  poke-poke-dex
//
//  Created by kohaka on 2022/10/02.
//

import Foundation
import Moya

enum PokeApi {
    case list
    case detail(Int)
}

extension PokeApi: TargetType {

    var baseURL: URL { return URL(string: "https://pokeapi.co/api/v2/")! }

    var path: String {
        switch self {
            case .list: return "/pokemon"
            case .detail(let id): return "/pokemon/\(id)"
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
