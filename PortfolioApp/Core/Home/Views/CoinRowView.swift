//
//  CoinRowView.swift
//  PortfolioApp
//
//  Created by Daichi Morihara on 2022/06/05.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    
    var body: some View {
        HStack {
            leftColumn
            Spacer()
            if (coin.currentHoldings ?? 0) > 0 {
                centerColumn
            }
            rightColumn
        }
        .contentShape(Rectangle())
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin)
    }
}

extension CoinRowView {
    
    private var leftColumn: some View {
        HStack(spacing: 5) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(.theme.secondary)
            
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(.theme.accent)
        }
    }
    
    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldintsValue.asCurrencyWith2Decimals())
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(.theme.accent)
        .font(.headline)
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .foregroundColor(.theme.accent)
                .bold()
            
            Text(coin.priceChangePercentage24H?.asPercentageString() ?? "")
                .foregroundColor((coin.priceChangePercentage24H ?? 0) < 0 ? .theme.red : .theme.green)
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}
