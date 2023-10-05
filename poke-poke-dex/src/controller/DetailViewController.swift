//
//  DetailViewController.swift
//  poke-poke-dex
//
//  Created by kohsaka on 2023/10/03.
//

import UIKit
import RxSwift

class DetailViewController: UIViewController {

    static let identifier = "toDetail"

    var id = 0
    @IBOutlet private var img: UIImageView!
    @IBOutlet private var shinyImg: UIImageView!
    @IBOutlet private var name: UILabel!
    @IBOutlet private var genera: UILabel!
    @IBOutlet private var type: UILabel!
    @IBOutlet private var htwt: UILabel!
    @IBOutlet private var eggGroup: UILabel!
    @IBOutlet private var flavorTable: UITableView!
    @IBOutlet private var statusChart: StatusChart!

    private let viewModel = DetailViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        Observable.zip(
                self.viewModel.pokemon,
                self.viewModel.species,
                self.viewModel.fr_def_img,
                self.viewModel.fr_shi_img)
            .subscribe(onNext: { pokemon, species, img, shiImg in
                self.view.hideSkeleton()
                self.name.text = "No.\(pokemon.id) \(pokemon.name)"
                self.htwt.text = "\(pokemon.height / 10)kg / \(pokemon.weight / 10)m"
                self.type.text = pokemon.types.count < 2 ? pokemon.types[0].type.name
                    : "\(pokemon.types[0].type.name) / \(pokemon.types[1].type.name)"
                self.genera.text = species.genera.filter { $0.language.name == "en" }.first!.genus
                self.eggGroup.text = species.egg_groups.count < 2 ? species.egg_groups[0].name
                    : "\(species.egg_groups[0].name) / \(species.egg_groups[1].name)"
                self.img.image = img
                self.shinyImg.image = shiImg
                pokemon.stats.forEach({ stat in self.statusChart.stats.append(stat.base_stat) })
            }).disposed(by: disposeBag)

        self.viewModel.flavors
            .bind(to: flavorTable.rx.items(
                cellIdentifier: FlavorCell.identifier,
                cellType: FlavorCell.self)) { row, element, cell in
                    cell.version.text = element.version.name
                    cell.flavorText.text = element.flavor_text
                }
            .disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.showAnimatedGradientSkeleton()
        self.viewModel.fetchPokeSpecies(id: self.id)
        self.viewModel.fetchPokeDetail(id: self.id)
        self.viewModel.fetchImage(type: ImageApi.front_default(self.id))
        self.viewModel.fetchImage(type: ImageApi.front_shiny(self.id))
    }

    @IBAction private func dismiss() {
        dismiss(animated: true)
    }
}
