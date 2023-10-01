//
//  ListViewModel.swift
//  poke-poke-dex
//
//  Created by kohsaka on 2022/10/01.
//

import Foundation
import RxRelay
import RxSwift
import RxCocoa

class ListViewModel {

    private var disposeBag = DisposeBag()

    let pokemons = BehaviorRelay<[ListResponse.Results]>(value: [])

    func requestPokeList() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon") else { return }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.rx.response(request: urlRequest)
            .subscribe { [weak self] response, data in
                guard let pokemons = try? JSONDecoder().decode(ListResponse.self, from: data) else { return }
                self?.pokemons.accept(pokemons.results)
            } onError: { error in
                print(error.localizedDescription)
            }.disposed(by: self.disposeBag)
    }
}
