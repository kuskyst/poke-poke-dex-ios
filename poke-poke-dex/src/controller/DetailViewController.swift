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
    @IBOutlet private var backImg: UIImageView!
    @IBOutlet private var backShinyImg: UIImageView!
    @IBOutlet private var name: UILabel!
    @IBOutlet private var genera: UILabel!
    @IBOutlet private var type: UILabel!
    @IBOutlet private var htwt: UILabel!
    @IBOutlet private var eggGroup: UILabel!
    @IBOutlet private var flavorTable: UITableView!
    @IBOutlet private var statusChart: StatusChart!
    @IBOutlet private var close: UIButton!

    private let viewModel = DetailViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.close.rx.tap.subscribe{ _ in
            self.dismiss(animated: true)
        }.disposed(by: disposeBag)
        Observable.zip(
                self.viewModel.pokemon,
                self.viewModel.species,
                self.viewModel.fr_def_img,
                self.viewModel.fr_shi_img,
                self.viewModel.bk_def_img,
                self.viewModel.bk_shi_img)
            .subscribe(onNext: { pokemon, species, img, shiImg, bkImg, bkShiImg in
                self.view.hideSkeleton()
                self.name.text = "No.\(pokemon.id) \(pokemon.name)"
                self.htwt.text = "\(pokemon.height / 10)m / \(pokemon.weight / 10)kg"
                self.type.text = pokemon.types.count < 2 ? pokemon.types[0].type.name
                    : "\(pokemon.types[0].type.name) / \(pokemon.types[1].type.name)"
                self.genera.text = species.genera.filter { $0.language.name == "en" }.first!.genus
                self.eggGroup.text = species.egg_groups.count < 2 ? species.egg_groups[0].name
                    : "\(species.egg_groups[0].name) / \(species.egg_groups[1].name)"
                self.img.image = img
                self.shinyImg.image = shiImg
                self.backImg.image = bkImg
                self.backShinyImg.image = bkShiImg
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
        self.statusChart.stats = []
        self.viewModel.fetchPokeSpecies(id: self.id)
        self.viewModel.fetchPokeDetail(id: self.id)
        self.viewModel.fetchImage(type: ImageApi.front_default(self.id))
        self.viewModel.fetchImage(type: ImageApi.front_shiny(self.id))
        self.viewModel.fetchImage(type: ImageApi.back_default(self.id))
        self.viewModel.fetchImage(type: ImageApi.back_shiny(self.id))
    }

}
