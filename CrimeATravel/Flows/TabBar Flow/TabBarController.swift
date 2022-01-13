//
//  TabBarController.swift
//  Payvand
//
//  Created by Tim Nazar on 08/03/21.
//

import UIKit

class TabBarController: UITabBarController {

    lazy var homeTab: UINavigationController = {
        let vc = UIViewController()//HomeViewController()
        vc.view.backgroundColor = .systemGreen
//        let presenter = HomePresenter(view: vc)
//        vc.presenter = presenter
        let nc = UINavigationController(rootViewController: vc)
        nc.navigationItem.largeTitleDisplayMode = .never
        nc.setNavigationBarHidden(true, animated: false)
        nc.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(named: "tab.bar.home"), tag: 0)
        return nc
    }()
    
    lazy var mapsTab: UINavigationController = {
        let vc = UIViewController()//CategoriesViewController()
        vc.view.backgroundColor = .systemRed
        let nc = UINavigationController(rootViewController: vc)
        nc.tabBarItem = UITabBarItem(title: "Карта", image: UIImage(named: "tab.bar.maps"), tag: 1)
        return nc
    }()
    
    lazy var servicesTab: UINavigationController = {
        let vc = UIViewController()//HelpViewController()
        vc.view.backgroundColor = .systemBlue
        let nc = UINavigationController(rootViewController: vc)
        nc.tabBarItem = UITabBarItem(title: "Сервисы", image: UIImage(named: "tab.bar.services"), tag: 2)
        return nc
    }()
    
    lazy var profileTab: UINavigationController = {
        let vc = UIViewController()//HelpViewController()
        vc.view.backgroundColor = .systemOrange
        let nc = UINavigationController(rootViewController: vc)
        nc.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "tab.bar.profile"), tag: 3)
        return nc
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [homeTab, mapsTab, servicesTab, profileTab]
        tabBar.tintColor = .systemBlue
    }
    
}
