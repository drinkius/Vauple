//
//  TabBarController.swift
//  truthordare
//
//  Created by Alexander Telegin on 20.08.2023.
//

import UIKit

class TabBarController: UITabBarController {
    static let shared = TabBarController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up your view controllers for each tab
        let firstViewController = ViewController()
        let secondViewController = SecondController()

        viewControllers = [
            firstViewController,
            secondViewController,
        ]

        // Customize the appearance of the tab bar items
        let tabBarItem1 = UITabBarItem(
            title: "Vault",
            image: UIImage(systemName: "dollarsign.square.fill"),
            selectedImage: UIImage(systemName: "dollarsign.square.fill")
        )
        let tabBarItem2 = UITabBarItem(
            title: "Accounts",
            image: UIImage(systemName: "person.2.badge.gearshape"),
            selectedImage: UIImage(systemName: "person.2.badge.gearshape.fill")
        )

        firstViewController.tabBarItem = tabBarItem1
        secondViewController.tabBarItem = tabBarItem2

        // Optionally, customize the appearance of the tab bar
        tabBar.tintColor = .orange
    }
}

