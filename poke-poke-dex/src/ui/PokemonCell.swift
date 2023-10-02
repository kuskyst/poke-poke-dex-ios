//
//  PokemonCell.swift
//  poke-poke-dex
//
//  Created by kohsaka on 2022/10/12.
//

import UIKit
import RxSwift

class PokemonCell: UITableViewCell {

    static var identifier = "PokemonCell"
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var img: UIImageView!

    private let detailViewModel = DetailViewModel()
    private let disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(model: ListResponse.Results, row: Int) {
        name.text = "\(model.url.lastPathComponent).\(model.name)"
        detailViewModel.requestPokeDetail(id: Int(model.url.lastPathComponent)!)
        //detailViewModel.pokemon.bind(to: type.rx.text).disposed(by: disposeBag)
    }

}
