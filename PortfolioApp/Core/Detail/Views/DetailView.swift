//
//  DetailView.swift
//  PortfolioApp
//
//  Created by Daichi Morihara on 2022/06/07.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    let coin: CoinModel
    
    var body: some View {

        
        /*
//        VStack(alignment: .leading) {
//            Text(coin.currentPrice.asCurrencyWith6Decimals())
//                .font(.title2)
//                .fontWeight(.semibold)
//                .padding(.leading)
//
//            HStack(spacing: 0) {
//                Image(systemName: "triangle.fill")
//                    .font(.caption)
//                    .rotationEffect(Angle(degrees: (coin.priceChangePercentage24H ?? 0) >= 0 ? 0 : 180))
//
//                Text((coin.priceChangePercentage24H ?? 0) >= 0 ? "+" : "-")
//
//                Text(coin.priceChange24H?.asNumberString() ?? "")
//
//                Text("(\(coin.priceChangePercentage24H?.asPercentageString() ?? ""))")
//
//            }
//            .padding(.leading)
//            .foregroundColor(
//                (coin.priceChangePercentage24H ?? 0) >= 0 ?
//                Color.theme.green : Color.theme.red
//            )
//            ChartView(coin: coin)
//
//            Spacer()
//        }
         
        */
        ScrollView {
            ChartView(coin: coin)
        }
        .navigationTitle(coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Text(coin.symbol.uppercased())
                        .font(.headline)
                        .foregroundColor(.theme.accent)
                    CoinImageView(coin: coin)
                        .frame(width: 30, height: 30)
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailLoadingView(coin: .constant(dev.coin))
        }
    }
}
