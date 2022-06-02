//
//  NotedApp.swift
//  Noted
//
//  Created by Tino Purmann on 03.06.22.
//

import SwiftUI
import FirebaseCore
import FirebaseAnalytics
import FirebaseAuth


@main
struct NotedApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
   
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(Note())
    }
}
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
