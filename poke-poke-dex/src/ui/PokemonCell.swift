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
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var name: UILabel!
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
        let id = model.url.lastPathComponent
        self.id.text = "No.\(id)"
        self.name.text = model.name
        self.img.image = UIImage(url: "https://raw.githubusercontent.com/POKEAPI/sprites/master/sprites/pokemon/\(id).png")
    }

}
