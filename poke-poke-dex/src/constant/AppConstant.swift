//
//  AppConstant.swift
//  poke-poke-dex
//
//  Created by kohsaka on 2023/10/03.
//

class AppConstant {
    static let verList = ["赤緑","金銀", "RS", "DP", "BW", "XY", "SM", "剣盾"]
    static let paramList = [
        ListRequest(limit: 151, offset: 0),
        ListRequest(limit: 100, offset: 151),
        ListRequest(limit: 135, offset: 251),
        ListRequest(limit: 107, offset: 386),
        ListRequest(limit: 156, offset: 493),
        ListRequest(limit: 72, offset: 649),
        ListRequest(limit: 88, offset: 721),
        ListRequest(limit: 89, offset: 809)
    ]
}
