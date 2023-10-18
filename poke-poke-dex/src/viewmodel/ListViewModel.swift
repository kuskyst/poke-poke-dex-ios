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

    let pokemons = PublishRelay<[ListResponse.Results]>()
    let error = PublishRelay<Error>()

    func fetchPokeList(param: ListRequest) {
        let provider = MoyaProvider<PokeApi>()
        provider.rx.request(.list(param.limit, param.offset))
            .filterSuccessfulStatusCodes()
            .map(ListResponse.self)
            .subscribe(
                onSuccess: { pokemons in
                    self.pokemons.accept(pokemons.results)
                },
                onFailure: { error in
                    self.error.accept(error)
                }
            ).disposed(by: disposeBag)
    }

}
