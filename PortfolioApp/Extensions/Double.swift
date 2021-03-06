//
//  Double.swift
//  PortfolioApp
//
//  Created by Daichi Morihara on 2022/06/05.
//

import Foundation

extension Double {
    
    
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = false
        formatter.numberStyle = .currency
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = false
        formatter.numberStyle = .currency
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    func asPercentageString() -> String {
        return asNumberString() + "%"
    }
    
    func formatWithAbbreveatoins() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""
        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let formattedString = formatted.asNumberString()
            return "\(sign)\(formattedString)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let formattedString = formatted.asNumberString()
            return "\(sign)\(formattedString)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let formattedString = formatted.asNumberString()
            return "\(sign)\(formattedString)M"
        case 1_000...:
            let formatted = num / 1_000
            let formattedString = formatted.asNumberString()
            return "\(sign)\(formattedString)K"
        case 0...:
            return self.asNumberString()
        default:
            return "\(sign)\(num)"
        }
        
    }
    
}
