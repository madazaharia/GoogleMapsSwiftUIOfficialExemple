//
//  GoogleMapsSwiftUIOfficialExempleApp.swift
//  GoogleMapsSwiftUIOfficialExemple
//
//  Created by Madalin Zaharia on 25.10.2023.
//

import SwiftUI

@main
struct GoogleMapsSwiftUIOfficialExempleApp: App {
    // inject AppDelegate into SwiftUI lifecycle via adaptor
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
