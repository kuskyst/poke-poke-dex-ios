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
        self.view.showAnimatedSkeleton()
        self.viewModel.pokemons
            .bind(to: pokemonTable.rx.items(
                cellIdentifier: PokemonCell.identifier,
                cellType: PokemonCell.self)) { row, element, cell in
                    cell.configureCell(model: element)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
                        self.view.hideSkeleton()
                    }
                }
            .disposed(by: disposeBag)

        Observable.just(AppConstant.verList)
            .bind(to: verCarousel.rx.items(
                cellIdentifier: VerCell.identifier,
                cellType: VerCell.self)) { row, element, cell in
                    cell.ver.text = element
                }
            .disposed(by: disposeBag)
        self.verCarousel.rx.itemSelected
            .subscribe(onNext: { [unowned self] indexPath in
                self.verCarousel.scrollToItem(
                    at: indexPath,
                    at: .centeredHorizontally,
                    animated: true)
                self.view.showAnimatedSkeleton()
                self.viewModel.fetchPokeList(param: AppConstant.paramList[indexPath.row])
            }).disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.fetchPokeList(param: ListRequest(limit: 20, offset: 0))
    }

}
