//
//  CoinImageView.swift
//  PortfolioApp
//
//  Created by Daichi Morihara on 2022/06/05.
//

import SwiftUI

struct CoinImageView: View {
    
    @ObservedObject var vm: CoinImageViewModel
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        vm = CoinImageViewModel(coin: coin)
    }
    
    
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Circle()
                    .foregroundColor(.theme.accent)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
            .frame(width: 100, height: 100)
    }
}
