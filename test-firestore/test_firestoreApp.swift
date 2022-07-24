//
//  test_firestoreApp.swift
//  test-firestore
//
//  Created by Vlad Sobchuk on 7/19/22.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }

}

@main
struct test_firestoreApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @AppStorage("userId") var userId: String = ""
    
    var body: some Scene {
        WindowGroup {
            if userId.isEmpty {
                OnboardingView()
            } else {
                ContentView()
            }
        }
    }
}
