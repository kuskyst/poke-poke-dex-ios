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

    var version = 0
    private var selected = 0
    static let identifier = "listViewController"

    @IBOutlet private weak var pokemonTable: UITableView!
    @IBOutlet private weak var refresh: UIButton!

    private let viewModel = ListViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.pokemonTable.rowHeight = UITableView.automaticDimension
        self.viewModel.pokemons
            .bind(to: pokemonTable.rx.items(
                cellIdentifier: PokemonCell.identifier,
                cellType: PokemonCell.self)) { row, element, cell in
                    cell.configureCell(model: element)
                    self.view.hideSkeleton()
                }
            .disposed(by: disposeBag)
        self.pokemonTable.rx.modelSelected(ListResponse.Results.self)
            .subscribe(
                onNext: { [weak self] model in
                    self?.selected = Int(model.url.lastPathComponent)!
                    self?.performSegue(withIdentifier: DetailViewController.identifier, sender: nil)
                },
                onError: { [weak self] error in
                    self?.refresh.setTitle("Status Code:\(error.asAFError?.responseCode ?? 200)", for: .normal)
                    self?.refresh.isHidden = false
                })
            .disposed(by: disposeBag)

        self.refresh.rx.tap.subscribe{ _ in
            self.refresh.isHidden = true
            self.viewModel.fetchPokeList(param: AppConstant.paramList[self.version])
        }.disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.showAnimatedGradientSkeleton()
        self.viewModel.fetchPokeList(param: AppConstant.paramList[self.version])
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let next = segue.destination as? DetailViewController
        next?.id = self.selected
    }
}
