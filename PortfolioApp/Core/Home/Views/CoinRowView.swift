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
            Text("\(coin.rank)")
                .foregroundColor(.theme.secondary)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
            Spacer()
            
            
            
            VStack(alignment: .trailing) {
                Text(coin.currentPrice.asCurrencyWith6Decimals())
                    .bold()
                
                Text(coin.priceChangePercentage24H?.asPercentageString() ?? "")
                    .foregroundColor((coin.priceChangePercentage24H ?? 0) < 0 ? .theme.red : .theme.green)
            }
            .frame(width: UIScreen.main.bounds.width / 3, alignment: .trailing)
        }
        .foregroundColor(.theme.accent)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin)
    }
}
