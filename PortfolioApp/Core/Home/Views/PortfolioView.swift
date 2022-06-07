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
    @State private var quantityText = ""
    @State private var isSaving = false
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(searchText: $vm.searchText)
                coinLogoList
                portfolioInputSection
                Spacer()
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    xmarkButton
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Image(systemName: "checkmark")
                            .opacity(isSaving ? 1.0 : 0.0)
                        Button {
                            saveIsPressed()
                        } label: {
                            Text("SAVE")
                        }
                        .opacity(
                            (selectedCoin != nil &&
                             selectedCoin?.currentHoldings != Double(quantityText)) ?
                            1.0 : 0.0
                        )

                    }
                }
            }
            .onChange(of: vm.searchText) { value in
                if value == "" {
                    selectedCoin = nil
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
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
    
    private func saveIsPressed() {
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText) else { return }
        
        // save to portfolio
        vm.updatePortfolio(coin: coin, amount: amount)

        // show checkmark
        isSaving = true
        removeSelectedCoin()
        
        // hide keyboard
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isSaving = false
        }
    }
    
    private func getCurrentValue() -> String {
        guard let amount = Double(quantityText),
              let coin = selectedCoin else {
            return "$0.00"
        }
        let value = amount * coin.currentPrice
        return value.asCurrencyWith2Decimals()
    }
    
    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin
        if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id }),
           let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
    }
    
    
    
    private var xmarkButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .foregroundColor(.theme.accent)
        }
    }
    
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top, spacing: 10) {
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
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
                            updateSelectedCoin(coin: coin)
                        }
                }
            }
            .frame(height: 110)
            .padding(.leading)
        }
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 15) {
            if let coin = selectedCoin {
                HStack {
                    Text("Current price of \(coin.symbol.uppercased())")
                    Spacer()
                    Text(coin.currentPrice.asCurrencyWith6Decimals())
                }
                Divider()
                HStack {
                    Text("Amount holding")
                    Spacer()
                    TextField("Ex: 1.6", text: $quantityText)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                    
                }
                Divider()
                HStack {
                    Text("Current value")
                    Spacer()
                    Text(getCurrentValue())
                }
            }
            
        }
        .font(.headline)
        .foregroundColor(.theme.accent)
        .padding()
    }
}
