//
//  VerCell.swift
//  poke-poke-dex
//
//  Created by kohsaka on 2022/10/03.
//

import UIKit

class VerCell: UICollectionViewCell {

    static let identifier: String = "VerCell"
    @IBOutlet weak var ver: UILabel!

    let name: String
    let param: ListRequest

    init(name: String, param: ListRequest) {
        self.name = name
        self.param = param
        super.init(frame: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
