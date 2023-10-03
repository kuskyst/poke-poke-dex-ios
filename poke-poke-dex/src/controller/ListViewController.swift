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
    private var selected = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.pokemons
            .bind(to: pokemonTable.rx.items(
                cellIdentifier: PokemonCell.identifier,
                cellType: PokemonCell.self)) { row, element, cell in
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                        self.view.hideSkeleton()
                        cell.configureCell(model: element)
                    }
                }
            .disposed(by: disposeBag)
        self.pokemonTable.rx.modelSelected(ListResponse.Results.self)
            .subscribe(onNext: { [weak self] model in
                self!.selected = Int(model.url.lastPathComponent)!
                self?.performSegue(withIdentifier: "toDetail", sender: nil)
            })
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
        self.view.showAnimatedSkeleton()
        self.viewModel.fetchPokeList(param: ListRequest(limit: 20, offset: 0))
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let next = segue.destination as? DetailViewController
        next?.id = self.selected
    }
}
