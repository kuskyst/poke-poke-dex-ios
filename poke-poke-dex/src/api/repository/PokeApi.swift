//
//  PokeApi.swift
//  poke-poke-dex
//
//  Created by kohaka on 2022/10/02.
//

import Foundation
import Moya

enum PokeApi {
    case list(Int, Int)
    case detail(Int)
    case species(Int)
}

extension PokeApi: TargetType {

    var baseURL: URL { return URL(string: "https://pokeapi.co/api/v2/")! }

    var path: String {
        switch self {
            case .list(_, _): return "/pokemon"
            case .detail(let id): return "/pokemon/\(id)"
            case .species(let id): return "/pokemon-species/\(id)"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Moya.Task {
        switch self {
            case .list(let limit, let offset):
                return .requestParameters(
                    parameters: ["limit": limit, "offset": offset],
                    encoding: URLEncoding.queryString)
            case .detail(_): return .requestPlain
            case .species(_): return .requestPlain
        }
    }

    var headers: [String : String]? {
        return nil
    }

}
