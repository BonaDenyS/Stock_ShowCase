//
//  AppCoordinator.swift
//  AIAStock
//
//  Created by Bona Deny S on 10/9/20.
//  Copyright © 2020 Bona Deny S. All rights reserved.
//

import UIKit


class AppCoordinator {
    let window: UIWindow
    
    var coordinators: [CoordinatorProtocol] = []
    
    init(window: UIWindow) {
        self.window = window
    }
}

extension AppCoordinator {
    
    func start() {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.isTranslucent = false
        tabBarController.viewControllers = []
        
        let firstTab = createNavigationController(withTitle: "Stock")
        let secondTab = createNavigationController(withTitle: "Compare")
        let thirdTab = createNavigationController(withTitle: "Setting")

        let firstCoordinator = FirstCoordinator(navigationController: firstTab)
        coordinators.append(firstCoordinator)
        firstCoordinator.start()
        
        let secondCoordinator = SecondCoordinator(navigationController: secondTab)
        coordinators.append(secondCoordinator)
        secondCoordinator.start()
        
        let thirdCoordinator = ThirdCoordinator(navigationController: thirdTab)
        coordinators.append(thirdCoordinator)
        thirdCoordinator.start()
        
        let rootViewControllers = [firstTab,secondTab,thirdTab]
        tabBarController.setViewControllers(rootViewControllers, animated: false)
        tabBarController.tabBar.tintColor = #colorLiteral(red: 0.8823710084, green: 0.02105199732, blue: 0.1260389984, alpha: 1)
        
        window.rootViewController = tabBarController
    }
    
    func createNavigationController(withTitle title: String) -> UINavigationController {
            let navController = UINavigationController()
            navController.navigationBar.isTranslucent = false
            
            navController.tabBarItem = UITabBarItem(title: title, image: nil, selectedImage: nil)
            navController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            
            return navController
        }
}
