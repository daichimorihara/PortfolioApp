//
//  ChartView.swift
//  PortfolioApp
//
//  Created by Daichi Morihara on 2022/06/07.
//

import SwiftUI

struct ChartView: View {
    
    let data: [Double]
    let minY: Double
    let maxY: Double
    
    var yAxis: Double {
        maxY - minY
    }
    
    init(coin: CoinModel) {
        self.data = coin.sparklineIn7D?.price ?? []
        self.minY = data.min() ?? 0
        self.maxY = data.max() ?? 0
        
    }
    
    var body: some View {
        
        Text("FI")
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
}
