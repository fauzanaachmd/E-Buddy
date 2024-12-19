//
//  E_BuddyApp.swift
//  E-Buddy
//
//  Created by Achmad Fauzan on 19/12/2024.
//

import FirebaseCore
import netfox
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        NFX.sharedInstance().start()

        return true
    }
}

@main
struct E_BuddyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
