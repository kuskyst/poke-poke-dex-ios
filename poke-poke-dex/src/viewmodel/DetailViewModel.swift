//
//  DetailViewModel.swift
//  poke-poke-dex
//
//  Created by kohsaka on 2022/10/02.
//

import RxSwift
import RxRelay
import Moya
import UIKit

class DetailViewModel {

    private var disposeBag = DisposeBag()

    let pokemon = PublishRelay<DetailResponse>()
    let fr_def_img = PublishRelay<UIImage>()

    func fetchPokeDetail(id: Int) {
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

    func fetchFrontDefaultImage(id: Int) {
        let provider = MoyaProvider<ImageApi>()
        provider.rx.request(.front_default(id))
            .mapImage()
            .subscribe(
                onSuccess: { image in
                    self.fr_def_img.accept(image)
                },
                onFailure: { error in
                    print(error)
                }
            ).disposed(by: disposeBag)
    }

}
