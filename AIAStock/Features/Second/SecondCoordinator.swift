//
//  SecondCoordinator.swift
//  AIAStock
//
//  Created by Bona Deny S on 10/9/20.
//  Copyright © 2020 Bona Deny S. All rights reserved.
//

import UIKit

class SecondCoordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension SecondCoordinator: CoordinatorProtocol {
    func start() {
        let secondView = SecondViewController.create()
        let viewModel = SecondViewModel()
        secondView.viewModel = viewModel
//        navigationController.tabBarItem.image = UIImage(named: "First")!.resized(toWidth: 30.0)
        navigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 3.0, right: 2.0)
        navigationController.pushViewController(secondView, animated: true)
    }
}
