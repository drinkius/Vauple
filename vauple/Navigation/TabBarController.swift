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
            title: "First",
            image: UIImage(systemName: "multiply.circle.fill"),
            selectedImage: UIImage(systemName: "folder")
        )
        let tabBarItem2 = UITabBarItem(
            title: "Second",
            image: UIImage(systemName: "multiply.circle.fill"),
            selectedImage: UIImage(systemName: "folder")
        )

        firstViewController.tabBarItem = tabBarItem1
        secondViewController.tabBarItem = tabBarItem2

        // Optionally, customize the appearance of the tab bar
        tabBar.tintColor = .orange
    }
}

