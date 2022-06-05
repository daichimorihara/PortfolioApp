//
//  HomeViewModel.swift
//  PortfolioApp
//
//  Created by Daichi Morihara on 2022/06/05.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var allCoins = [CoinModel]()
    @Published var portfolioCoins = [CoinModel]()
    
    private let coinDataService = CoinDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        // updates allCoins
        coinDataService.$allCoins
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
}
