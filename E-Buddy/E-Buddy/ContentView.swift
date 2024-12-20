//
//  ContentView.swift
//  E-Buddy
//
//  Created by Achmad Fauzan on 19/12/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            if let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") {
                print("Firebase Config: \(path)")
            }
        }
    }
}

#Preview {
    ContentView()
}
