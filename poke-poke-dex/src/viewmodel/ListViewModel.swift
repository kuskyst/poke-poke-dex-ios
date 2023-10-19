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

    private let disposeBag = DisposeBag()

    let pokemons = PublishSubject<[ListResponse.Results]>()

    func fetchPokeList(param: ListRequest) {
        let provider = MoyaProvider<PokeApi>()
        provider.rx.request(.list(param.limit, param.offset))
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
