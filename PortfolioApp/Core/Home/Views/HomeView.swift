//
//  HomeView.swift
//  PortfolioApp
//
//  Created by Daichi Morihara on 2022/06/04.
//

import SwiftUI

struct HomeView: View {
    @State private var showPortfolio = false
    @EnvironmentObject var vm: HomeViewModel
    
    var body: some View {
        VStack {
            homeHeader
            coinListTitle
            
            if !showPortfolio {
                allCoinsList
                    .transition(.move(edge: .leading))
            }
            
            if showPortfolio {
                portfolioCoinsList
                    .transition(.move(edge: .trailing))
            }

            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(dev.homeVM)
    }
}

extension HomeView {
    
    private var homeHeader: some View {
        HStack {
            Image(systemName: showPortfolio ? "plus" : "info")
                .frame(width: 40, height: 40)
                .overlay(Circle().stroke().opacity(0.1))
                .animation(.none, value: showPortfolio)
            
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .animation(.none)
            Spacer()
            
            Image(systemName: "chevron.right")
                .frame(width: 40, height: 40)
                .overlay(Circle().stroke().opacity(0.1))
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation {
                        showPortfolio.toggle()
                    }
                }
        }
        .font(.headline)
        .foregroundColor(.theme.accent)
        .padding()
    }
    
    private var coinListTitle: some View {
        HStack {
            Text("Coin")
            Spacer()
            
            if showPortfolio {
                Text("Holdings")
            }
            
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .foregroundColor(.theme.secondary)
        .font(.caption)
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin)
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin)
            }
        }
        .listStyle(PlainListStyle())
    }
}
