//
//  AppDelegate.swift
//  CrimeATravel
//
//  Created by Murad Ibrohimov on 13.01.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        configureNavigationBar()
        window?.rootViewController = OnboardingVC()//TabBarController()
        window?.makeKeyAndVisible()
        return true
    }
}

extension AppDelegate {
    
    private func configureNavigationBar() {
        UINavigationBar.appearance().tintColor = .white
        
        if #available(iOS 15, *) {
            let navBarAppearance = UINavigationBarAppearance()
            UINavigationBar.appearance().standardAppearance = navBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
            
            let tabBarAppearance = UITabBarAppearance()
            UITabBar.appearance().standardAppearance = tabBarAppearance
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
    
}
