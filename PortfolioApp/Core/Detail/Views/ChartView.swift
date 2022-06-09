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
    let lineColor: Color
    
    var yAxis: Double {
        maxY - minY
    }
    
    init(coin: CoinModel) {
        self.data = coin.sparklineIn7D?.price ?? []
        self.minY = data.min() ?? 0
        self.maxY = data.max() ?? 0
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        self.lineColor = priceChange < 0 ? .theme.red : .theme.green
        
    }
    
    var body: some View {
        VStack(spacing: 0) {
            chart
                .frame(height: 200)
                .background(chartBackground)
                .overlay(yAxisChart,alignment: .leading)
     
            xAxisChart
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
            //.preferredColorScheme(.dark)
    }
}

extension ChartView {
    
    private var chart: some View {
        GeometryReader { geometry in
            Path { path in
                for idx in data.indices {

                    let xPosition = geometry.size.width * CGFloat(idx + 1) / CGFloat(data.count)

                    //let yPosition = geometry.size.height * CGFloat(1 - (data[idx] - minY)) / CGFloat(yAxis)
                    let yPosition = geometry.size.height * CGFloat(1 - ((data[idx] - minY) / CGFloat(yAxis)))

                    if idx == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .stroke(lineWidth: 2)
            .foregroundColor(lineColor)
        }
    }
    
    private var chartBackground: some View {
        ZStack {
            VStack {
                Divider()
                Spacer()
                Divider()
                Spacer()
                Divider()
                Spacer()
                Divider()
                Spacer()
                Divider()
            }
            
            HStack {
                Divider()
                Spacer()
                Divider()
                Spacer()
                Divider()
                Spacer()
                Divider()
                Spacer()
                Divider()
            }
        }
    }
    
    private var yAxisChart: some View {
        VStack {
            Text(maxY.formatWithAbbreveatoins())
            Spacer()
            Text(((maxY + minY) / 2).formatWithAbbreveatoins())
            Spacer()
            Text(minY.formatWithAbbreveatoins())
        }
        .foregroundColor(.theme.secondary)
        .font(.caption)
    }
    
    private var xAxisChart: some View {
        HStack {
            Text("7d Ago")
            Spacer()
            Text("Today")
        }
        .foregroundColor(.theme.secondary)
        .font(.caption)
    }
    
}
