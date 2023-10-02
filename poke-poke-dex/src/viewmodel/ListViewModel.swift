//
//  ListViewModel.swift
//  poke-poke-dex
//
//  Created by kohsaka on 2022/10/01.
//

import RxRelay
import RxSwift
import Moya
import RxMoya

class ListViewModel {

    private var disposeBag = DisposeBag()

    let pokemons = BehaviorRelay<[ListResponse.Results]>(value: [])

    func requestPokeList() {
        let provider = MoyaProvider<PokeApi>()
        provider.rx.request(.list)
            .filterSuccessfulStatusCodes()
            .map(ListResponse.self)
            .subscribe(
                onSuccess: { pokemons in
                    self.pokemons.accept(pokemons.results)
                },
                onFailure: { error in
                    print(error)
                }
            ).disposed(by: disposeBag)
    }
}