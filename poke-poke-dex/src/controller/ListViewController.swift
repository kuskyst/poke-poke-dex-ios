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

    private let verList: [String] = ["赤緑", "金銀", "RS", "DP", "BW", "SM", "剣盾"]

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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.fetchPokeList(param: param)
    }

}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        verList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerCell.identifier, for: indexPath)
        (cell as! VerCell).name.text = verList[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
