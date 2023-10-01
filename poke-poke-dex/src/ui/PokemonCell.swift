//
//  PokemonCell.swift
//  poke-poke-dex
//
//  Created by kohsaka on 2022/10/12.
//

import UIKit

class PokemonCell: UITableViewCell {

    static var identifier = "PokemonCell"
    // ID
    internal var id: Int!
    // 名称
    @IBOutlet weak var name: UILabel!
    // イメージ
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(model: ListResponse.Results, row: Int) {
        name.text = model.name
    }

}
