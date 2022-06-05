//
//  CoinImageViewModel.swift
//  PortfolioApp
//
//  Created by Daichi Morihara on 2022/06/05.
//

import Foundation
import UIKit
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage?
    @Published var isLoading = false
    
    private let coinImageService: CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coinImageService = CoinImageService(coin: coin)
        self.isLoading = true
        addSubscribers()
    }
    
    func addSubscribers() {
        
        coinImageService.$image
            .sink { [weak self] returnedImage in
                self?.image = returnedImage
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
}
