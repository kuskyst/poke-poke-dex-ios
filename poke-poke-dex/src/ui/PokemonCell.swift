//
//  PokemonCell.swift
//  poke-poke-dex
//
//  Created by kohsaka on 2022/10/12.
//

import UIKit
import RxSwift

class PokemonCell: UITableViewCell {

    static let identifier = "PokemonCell"
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var img: UIImageView!

    private let viewModel = DetailViewModel()
    private let disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(model: ListResponse.Results) {
        self.id.text = "No.\(model.url.lastPathComponent)"
        self.name.text = model.name
        self.viewModel.fetchFrontDefaultImage(id: Int(model.url.lastPathComponent) ?? 0)
        self.viewModel.fr_def_img.bind(to: img.rx.image).disposed(by: self.disposeBag)
    }

}
