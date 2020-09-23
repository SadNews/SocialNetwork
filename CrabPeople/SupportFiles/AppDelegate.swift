//
//  AppDelegate.swift
//  CrabPeople
//
//  Created by Андрей Ушаков on 18.09.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        window?.rootViewController = NewsFeedViewController()

        window?.rootViewController = UINavigationController(rootViewController: NewsFeedViewController())
        UINavigationBar.appearance().barTintColor =  .blue
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        window?.makeKeyAndVisible()
        return true
    }



}

