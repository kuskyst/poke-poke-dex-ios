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
    @IBOutlet private weak var undeline: UIView!

    override var isSelected: Bool {
        didSet { self.undeline.isHidden = !isSelected }
    }
}
