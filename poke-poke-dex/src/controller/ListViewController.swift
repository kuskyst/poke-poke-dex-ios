//
//  ListViewController.swift
//  poke-poke-dex
//
//  Created by kohsaka on 2022/10/01.
//

import UIKit
import RxSwift
import RxCocoa
import SkeletonView

class ListViewController: UIViewController {

    @IBOutlet private weak var verCarousel: UICollectionView!
    @IBOutlet private weak var pokemonTable: UITableView!

    private let viewModel = ListViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.showSkeleton()
        self.viewModel.pokemons
            .bind(to: pokemonTable.rx.items(
                cellIdentifier: PokemonCell.identifier,
                cellType: PokemonCell.self)) { row, element, cell in
                    cell.configureCell(model: element)
                    self.view.hideSkeleton()
                }
            .disposed(by: disposeBag)

        let data = Observable<[VerCell]>.just([
            VerCell(name: "赤緑", param: ListRequest(limit: 151, offset: 0)),
            VerCell(name: "金銀", param: ListRequest(limit: 151, offset: 0)),
            VerCell(name: "RS", param: ListRequest(limit: 151, offset: 0)),
            VerCell(name: "DP", param: ListRequest(limit: 151, offset: 0)),
            VerCell(name: "BW", param: ListRequest(limit: 151, offset: 0)),
            VerCell(name: "XY", param: ListRequest(limit: 151, offset: 0)),
            VerCell(name: "SM", param: ListRequest(limit: 151, offset: 0)),
            VerCell(name: "剣盾", param: ListRequest(limit: 151, offset: 0)),
        ])
        data.bind(to: verCarousel.rx.items(
            cellIdentifier: "VerCell",
            cellType: VerCell.self)) { row, element, cell in
                cell.ver.text = element.name
            }
            .disposed(by: disposeBag)
        self.verCarousel.rx.itemSelected
            .subscribe(onNext: { [unowned self] indexPath in
                self.verCarousel.scrollToItem(
                    at: indexPath,
                    at: .centeredHorizontally,
                    animated: true)
            }).disposed(by: disposeBag)

        verCarousel.rx.modelSelected(VerCell.self)
            .subscribe(onNext: { [weak self] model in
                self!.viewModel.fetchPokeList(param: model.param)
            }).disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.fetchPokeList(param: ListRequest(limit: 20, offset: 0))
    }

}
