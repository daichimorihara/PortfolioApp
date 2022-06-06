//
//  PortfolioView.swift
//  PortfolioApp
//
//  Created by Daichi Morihara on 2022/06/06.
//

import SwiftUI

struct PortfolioView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: HomeViewModel
    @State private var selectedCoin: CoinModel?
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(searchText: $vm.searchText)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .top, spacing: 10) {
                        ForEach(vm.allCoins) { coin in
                            CoinLogoView(coin: coin)
                                .frame(width: 70)
                                .padding(.vertical, 3)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke()
                                        .foregroundColor(.theme.green)
                                        .opacity(selectedCoin?.id == coin.id ? 1.0 : 0.0)
                                )
                                .onTapGesture {
                                    selectedCoin = coin
                                }
                        }
                    }
                    .padding(.leading, 10)
                    .padding(.top, 10)
                }
                
                Spacer()
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    xmarkButton
                }
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}

extension PortfolioView {
    private var xmarkButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .foregroundColor(.theme.accent)
        }
    }
}
