//
//  TabViewController.swift
//  poke-poke-dex
//  
//  Created by kohsaka on 2023/10/06
//  
//

import UIKit
import Parchment

class TabViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var vcs: [ListViewController] = []
        AppConstant.verList.enumerated().forEach { index, ver in
            let vc = storyboard!.instantiateViewController(identifier:
                ListViewController.identifier) as ListViewController?
            vc!.version = index
            vc!.title = ver
            vcs.append(vc!)
        }
        let pagingViewController = PagingViewController(viewControllers: vcs)

        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false

        pagingViewController.textColor = .white
        pagingViewController.menuBackgroundColor = UIColor(red: 248/255, green: 210/255, blue: 252/255, alpha: 1.0)
        pagingViewController.selectedTextColor = UIColor(red: 209/255, green: 45/255, blue: 125/255, alpha: 1.0)
        pagingViewController.indicatorColor = pagingViewController.selectedTextColor
        pagingViewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pagingViewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pagingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        pagingViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
}
