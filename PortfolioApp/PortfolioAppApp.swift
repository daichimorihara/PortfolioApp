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
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
