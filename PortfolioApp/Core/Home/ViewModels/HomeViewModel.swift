//
//  HomeViewModel.swift
//  PortfolioApp
//
//  Created by Daichi Morihara on 2022/06/05.
//

import Foundation
import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var allCoins = [CoinModel]()
    @Published var portfolioCoins = [CoinModel]()
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService()
    private let portfolioDataService = PortfolioDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        // updates allCoins
        coinDataService.$allCoins
            .combineLatest($searchText)
            .map({ (coins, text) -> [CoinModel] in
                guard !text.isEmpty else {
                    return coins
                }
                let lowercasedText = text.lowercased()
                
                return coins.filter({
                    $0.symbol.contains(lowercasedText) ||
                    $0.id.contains(lowercasedText) ||
                    $0.name.contains(lowercasedText)
                })
            })
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // updates portflioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map { (coins, entities) -> [CoinModel] in
                coins
                    .compactMap { coin -> CoinModel? in
                        guard let entity = entities.first(where: { $0.coinID == coin.id }) else {
                            return nil
                        }
                        return coin.updateHoldings(amount: entity.amount)
                    }
            }
            .sink { [weak self] returnedCoins in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
}
