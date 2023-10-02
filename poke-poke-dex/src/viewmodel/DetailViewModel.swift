//
//  DetailViewModel.swift
//  poke-poke-dex
//
//  Created by kohsaka on 2022/10/02.
//

import RxSwift
import RxRelay
import Moya

class DetailViewModel {

    private var disposeBag = DisposeBag()

    let pokemon = BehaviorRelay<DetailResponse?>(value: nil)
    let stg = BehaviorRelay<String>(value: "")

    func requestPokeDetail(id: Int) {
        let provider = MoyaProvider<PokeApi>()
        provider.rx.request(.detail(id))
            .filterSuccessfulStatusCodes()
            .map(DetailResponse.self)
            .subscribe(
                onSuccess: { pokemon in
                    self.pokemon.accept(pokemon)
                },
                onFailure: { error in
                    print(error)
                }
            ).disposed(by: disposeBag)
    }
}
