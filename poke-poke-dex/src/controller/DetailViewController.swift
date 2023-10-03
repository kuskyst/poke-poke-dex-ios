//
//  DetailViewController.swift
//  poke-poke-dex
//
//  Created by kohsaka on 2023/10/03.
//

import UIKit
import RxSwift

class DetailViewController: UIViewController {

    var id = 0
    @IBOutlet private var name: UILabel!

    private let viewModel = DetailViewModel()
    private let disposeBag = DisposeBag()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.name.bind(to: name.rx.text).disposed(by: disposeBag)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.view.hideSkeleton()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.showAnimatedSkeleton()
        self.viewModel.fetchPokeDetail(id: self.id)
    }

    @IBAction private func dismiss() {
        dismiss(animated: true)
    }
}
