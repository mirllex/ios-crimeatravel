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
        window = UIWindow(frame: UIScreen.main.bounds)
        
        configureNavigationBar()
        showAuth()
        window?.makeKeyAndVisible()
        return true
    }
}

extension AppDelegate {
    
    private func configureNavigationBar() {
        UINavigationBar.appearance().tintColor = UIColor(named: "accentColor")
        
        if #available(iOS 15, *) {
            let navBarAppearance = UINavigationBarAppearance()
            UINavigationBar.appearance().standardAppearance = navBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
            
            let tabBarAppearance = UITabBarAppearance()
            UITabBar.appearance().standardAppearance = tabBarAppearance
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
    
    func showHome(completion: (() -> Void)? = nil) {
        let tabbarVC = TabBarController()
        switchRootViewController(rootViewController: tabbarVC, animated: true, completion: completion)
    }
    
    func showAuth(completion: (() -> Void)? = nil) {
        Keychain.reset()
        Defaults.reset()
        let nc = UINavigationController(rootViewController: LoginVC())
        nc.navigationBar.setBackgroundColor(.clear)
        nc.navigationBar.tintColor = .black
        switchRootViewController(rootViewController: nc, animated: true, completion: completion)
    }
    
    private func switchRootViewController(rootViewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        if animated {
            UIView.transition(with: window!, duration: 0.5, options: .transitionCrossDissolve, animations: {
                let oldState: Bool = UIView.areAnimationsEnabled
                UIView.setAnimationsEnabled(false)
                self.window!.rootViewController = rootViewController
                UIView.setAnimationsEnabled(oldState)
            }, completion: { _ in
                completion?()
            })
        } else {
            window!.rootViewController = rootViewController
            completion?()
        }
    }
    
}
