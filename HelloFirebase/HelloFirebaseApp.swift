//
//  HelloFirebaseApp.swift
//  HelloFirebase
//
//  Created by Don McKenzie on 10/31/21.
//

import SwiftUI
import Firebase

@main
struct HelloFirebaseApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
