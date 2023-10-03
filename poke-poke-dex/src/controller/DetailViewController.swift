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
    @IBOutlet private var name: UILabel!
    @IBOutlet private var img: UIImageView!
    @IBOutlet private var shinyImg: UIImageView!

    private let viewModel = DetailViewModel()
    private let disposeBag = DisposeBag()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.name.bind(to: name.rx.text).disposed(by: disposeBag)
        self.viewModel.fr_def_img.bind(to: img.rx.image).disposed(by: disposeBag)
        self.viewModel.fr_shi_img.bind(to: shinyImg.rx.image).disposed(by: disposeBag)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.view.hideSkeleton()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.showAnimatedSkeleton()
        self.viewModel.fetchPokeDetail(id: self.id)
        self.viewModel.fetchImage(type: ImageApi.front_default(self.id))
        self.viewModel.fetchImage(type: ImageApi.front_shiny(self.id))
    }

    @IBAction private func dismiss() {
        dismiss(animated: true)
    }
}
