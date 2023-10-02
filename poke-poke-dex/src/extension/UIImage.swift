//
//  UIImage.swift
//  poke-poke-dex
//
//  Created by kohsaka on 2022/10/02.
//

import UIKit

extension UIImage {
    public convenience init(url: String) {
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            self.init(data: data)!
            return
        } catch let err {
            print("Error: \(err.localizedDescription)")
        }
        self.init()
    }
}
