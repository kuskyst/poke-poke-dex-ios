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
import Foundation
import UIKit

class ListViewModel {

    private var disposeBag = DisposeBag()

    let pokemons = PublishRelay<[ListResponse.Results]>()
    let image = PublishRelay<UIImage>()

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
    
    func fetchImage(id: Int) {
        let provider = MoyaProvider<ImageApi>()
        provider.rx.request(.front_default(id))
            .mapImage()
            .subscribe(
                onSuccess: { image in
                    self.image.accept(image)
                },
                onFailure: { error in
                    print(error)
                }
            ).disposed(by: disposeBag)
    }
}
