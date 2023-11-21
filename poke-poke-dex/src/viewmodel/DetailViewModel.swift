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

    private let pokeProvider: MoyaProvider<PokeApi>
    private let imageProvider: MoyaProvider<ImageApi>
    private let disposeBag = DisposeBag()

    let pokemon = PublishRelay<DetailResponse>()
    let species = PublishRelay<SpeciesResponse>()
    let flavors = PublishRelay<[SpeciesResponse.FlavorTextEntries]>()
    let fr_def_img = PublishRelay<UIImage>()
    let fr_shi_img = PublishRelay<UIImage>()
    let bk_def_img = PublishRelay<UIImage>()
    let bk_shi_img = PublishRelay<UIImage>()

    init(pokeProvider: MoyaProvider<PokeApi> = MoyaProvider<PokeApi>(),
         imageProvider: MoyaProvider<ImageApi> = MoyaProvider<ImageApi>()) {
        self.pokeProvider = pokeProvider
        self.imageProvider = imageProvider
    }

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

    func fetchPokeSpecies(id: Int) {
        self.pokeProvider.rx.request(.species(id))
            .filterSuccessfulStatusCodes()
            .map(SpeciesResponse.self)
            .subscribe(
                onSuccess: { species in
                    self.flavors.accept(species.flavor_text_entries.filter { $0.language.name == "ja" } )
                    self.species.accept(species)
                },
                onFailure: { error in
                    print(error)
                }
            ).disposed(by: disposeBag)
    }

    func fetchImage(type: ImageApi) {
        self.imageProvider.rx.request(type)
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
