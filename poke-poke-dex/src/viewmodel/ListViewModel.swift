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

    private let provider: MoyaProvider<PokeApi>
    private let disposeBag = DisposeBag()

    let pokemons = PublishSubject<[ListResponse.Results]>()

    init(provider: MoyaProvider<PokeApi> = MoyaProvider<PokeApi>()) {
        self.provider = provider
    }

    func fetchPokeList(param: ListRequest) {
        self.provider.rx.request(.list(param.limit, param.offset))
            .filterSuccessfulStatusCodes()
            .map(ListResponse.self)
            .subscribe(
                onSuccess: { pokemons in
                    self.pokemons.onNext(pokemons.results)
                },
                onFailure: { error in
                    self.pokemons.onError(error)
                }
            ).disposed(by: disposeBag)
    }

}
