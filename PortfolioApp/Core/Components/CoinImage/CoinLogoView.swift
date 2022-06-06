//
//  CoinLogoView.swift
//  PortfolioApp
//
//  Created by Daichi Morihara on 2022/06/06.
//

import SwiftUI

struct CoinLogoView: View {
    
    let coin: CoinModel
    
    var body: some View {
        VStack {
            CoinImageView(coin: coin)
                .frame(width: 40, height: 40)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(.theme.accent)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                
            Text(coin.name)
                .font(.caption)
                .foregroundColor(.theme.secondary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
            
        }
    }
}

struct CoinLogoView_Previews: PreviewProvider {
    static var previews: some View {
        CoinLogoView(coin: dev.coin)
            .previewLayout(.sizeThatFits)
    }
}
