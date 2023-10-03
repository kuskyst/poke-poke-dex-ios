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

    private let disposeBag = DisposeBag()

    let pokemon = PublishRelay<DetailResponse>()
    let name = PublishRelay<String>()
    let fr_def_img = PublishRelay<UIImage>()
    let fr_shi_img = PublishRelay<UIImage>()
    let bk_def_img = PublishRelay<UIImage>()
    let bk_shi_img = PublishRelay<UIImage>()

    func fetchPokeDetail(id: Int) {
        let provider = MoyaProvider<PokeApi>()
        provider.rx.request(.detail(id))
            .filterSuccessfulStatusCodes()
            .map(DetailResponse.self)
            .subscribe(
                onSuccess: { pokemon in
                    self.name.accept("No.\(pokemon.id) \(pokemon.name)")
                    self.pokemon.accept(pokemon)
                },
                onFailure: { error in
                    print(error)
                }
            ).disposed(by: disposeBag)
    }

    func fetchImage(type: ImageApi) {
        let provider = MoyaProvider<ImageApi>()
        provider.rx.request(type)
            .mapImage()
            .subscribe(
                onSuccess: { image in
                    switch type {
                        case .back_default(_): return self.bk_def_img.accept(image)
                        case .front_default(_): return self.fr_def_img.accept(image)
                        case .front_shiny(_): return self.fr_shi_img.accept(image)
                        case .back_shiny(_): return self.bk_shi_img.accept(image)
                    }
                },
                onFailure: { error in
                    print(error)
                }
            ).disposed(by: disposeBag)
    }

}
