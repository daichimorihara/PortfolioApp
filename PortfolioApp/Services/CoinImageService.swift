//
//  CoinImageService.swift
//  PortfolioApp
//
//  Created by Daichi Morihara on 2022/06/05.
//

import Foundation
import UIKit
import Combine

class CoinImageService {
    
    @Published var image: UIImage?
    private let coin: CoinModel
    private var imageSubscription: AnyCancellable?
    private let localFileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = localFileManager.getImage(folderName: folderName, imageName: imageName) {
            self.image = savedImage
            //print("Retrieved image from file manager")
        } else {
            downloadCoinImage()
            //print("Downloaded image from the internet")
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .map { data -> UIImage? in
                return UIImage(data: data)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion) { [weak self] returnedImage in
                guard let self = self,
                      let downloadedImage = returnedImage else { return }
                
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.localFileManager.saveImage(image: downloadedImage, folderName: self.folderName, imageName: self.imageName)
            }
    }
}
