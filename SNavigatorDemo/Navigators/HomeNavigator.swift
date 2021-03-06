//
//  HomeNavigator.swift
//  SNavigatorDemo
//
//  Created by Alex Nagy on 05/05/2020.
//  Copyright © 2020 Alex Nagy. All rights reserved.
//

import Foundation
import UIKit
import SparkUI

class HomeNavigator: Navigator {
    override func start() {
        super.start()
        
        let controller = HomeViewController()
        controller.setTabBarItem(selectedImageSystemImageName: "house.fill", unselectedImageSystemImageName: "house", selectedColor: .systemBlue, unSelectedColor: .systemGray3, title: "Home")
        controller.navigator = self
        navigation.display(controller)
        
        navigation.delegate = self
    }
}

extension HomeNavigator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        if let viewController = fromViewController as? AuthViewController {
            didDismiss(viewController.navigator)
        }
    }
}

protocol ProfileNavigatable: AnyObject {
    func presentProfile(uid: String)
    func pushProfile(uid: String)
}

extension HomeNavigator: ProfileNavigatable {
    
    func presentProfile(uid: String) {
        let controller = ProfileViewController()
        controller.uid = uid
        controller.navigator = self
        present(controller)
    }
    
    func pushProfile(uid: String) {
        let controller = ProfileViewController()
        controller.uid = uid
        controller.navigator = self
        navigation.push(controller)
    }
    
}


protocol AuthNavigatable: AnyObject {
    func presentAuthNavigation()
}

extension HomeNavigator: AuthNavigatable {
    func presentAuthNavigation() {
        let childNavigator = AuthNavigator()
        childNavigator.parentNavigator = self
        childNavigators.append(childNavigator)
        childNavigator.start()
    }
}

protocol ClassicSheetNavigatable: AnyObject {
    func presentFirstClassicSheet()
    func presentSecondClassicSheet()
}

extension HomeNavigator: ClassicSheetNavigatable {
    func presentFirstClassicSheet() {
        let controller = ClassicSheetFirstViewController()
        controller.navigator = self
        present(controller, animated: true)
    }
    
    func presentSecondClassicSheet() {
        let controller = ClassicSheetSecondViewController()
        controller.navigator = self
        present(controller, animated: true)
    }
    
}
