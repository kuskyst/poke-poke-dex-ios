//
//  VerCell.swift
//  poke-poke-dex
//
//  Created by kohsaka on 2022/10/03.
//

import UIKit

class VerCell: UICollectionViewCell {

    @IBOutlet weak var name: UIButton!

    static let identifier: String = "VerCell"

    static let widthInset: CGFloat = 20.0
    static let cellWidth: CGFloat = 330
    static let cellHeight: CGFloat = 240

    private let selectedFrameColor: CGColor = UIColor.tintColor.cgColor
    private let defaultFrameColor: CGColor = UIColor.systemGray5.cgColor

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
