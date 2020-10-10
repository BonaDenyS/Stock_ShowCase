//
//  ThirdCoordinator.swift
//  AIAStock
//
//  Created by Bona Deny S on 10/10/20.
//  Copyright © 2020 Bona Deny S. All rights reserved.
//

import UIKit

class ThirdCoordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension ThirdCoordinator: CoordinatorProtocol {
    func start() {
        let thirdView = ThirdViewController.create()
        let viewModel = ThirdViewModel()
        thirdView.viewModel = viewModel
        navigationController.tabBarItem.image = UIImage(named: "settings")!.resized(toWidth: 30.0)
        navigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 3.0, right: 2.0)
        navigationController.pushViewController(thirdView, animated: true)
    }
}
