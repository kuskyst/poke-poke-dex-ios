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

    @IBOutlet private weak var tableView: UITableView!

    private let listViewModel = ListViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableView.automaticDimension
        view.showAnimatedSkeleton()

        listViewModel.pokemons
            .bind(to: tableView.rx.items(
                cellIdentifier: PokemonCell.identifier,
                cellType: PokemonCell.self)) { row, element, cell in
                    cell.configureCell(model: element)
                }
            .disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listViewModel.requestPokeList()
    }

}
