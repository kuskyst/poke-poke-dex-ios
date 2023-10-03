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
    private var param = ListRequest(limit: 20, offset: 0)

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
        
        Observable.just(["赤緑", "金銀", "RS", "DP", "BW", "SM", "剣盾"])
            .bind(to: verCarousel.rx.items(
                cellIdentifier: VerCell.identifier,
                cellType: VerCell.self)) { row, element, cell in
                    cell.name.text = element
                }
            .disposed(by: disposeBag)
        
        verCarousel.rx.itemSelected
            .subscribe(onNext: { [unowned self] indexPath in
                self.verCarousel.scrollToItem(
                    at: indexPath,
                    at: .centeredHorizontally,
                    animated: true)
            }).disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.fetchPokeList(param: param)
    }

}
