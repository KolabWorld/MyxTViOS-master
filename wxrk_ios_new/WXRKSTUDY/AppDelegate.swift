//
//  AppDelegate.swift
//  WXRKSTUDY
//
//  Created by KaramjeetSingh on 29/07/22.
//

import UIKit
import RealmSwift
import IQKeyboardManagerSwift
import Lottie
import BloctoSDK
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var realm : Realm!
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared.enable = true
        LottieConfiguration.shared.renderingEngine = .automatic
        window = UIWindow(frame: UIScreen.main.bounds)
        FirebaseApp.configure()
        //dump(UIFont.familyNames.compactMap { UIFont.fontNames(forFamilyName: $0) })

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        
        return true
    }

    func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        return true
    }


}


//Decor:
 //APPLICATION ID : 1029300222536462396
//PUBLIC KEY : b405fa65d63fe72442b92d21ac6cc7da9eb13eb93e7214547ed4779c9a0a3767
// Client Id : 1029300222536462396
// CLIENT SECRET : 0CoCGGToFh8XNVUSDiYeoDbp-cnjxVDI 

