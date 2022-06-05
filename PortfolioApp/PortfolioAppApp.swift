//
//  PortfolioAppApp.swift
//  PortfolioApp
//
//  Created by Daichi Morihara on 2022/06/04.
//

import SwiftUI

@main
struct PortfolioAppApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .environmentObject(vm)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
