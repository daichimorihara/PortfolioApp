//
//  PortfolioDataService.swift
//  PortfolioApp
//
//  Created by Daichi Morihara on 2022/06/06.
//

import Foundation
import CoreData

class PortfolioDataService {
    let container: NSPersistentContainer
    let containerName = "PortfolioContainer"
    let entityName = "PortfolioEntity"
    
    @Published var savedEntities = [PortfolioEntity]()
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Failed to load Core Data \(error)")
            }
        }
    }
    
    // MAKR: PUBLIC
    func updatePortfolio(coin: CoinModel, amount: Double) {
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    // MARK: PRIVATE
    
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.amount = amount
        entity.coinID = coin.id
        applyChanges()
    }
    
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch {
            print("Falied to fetch Portfolio Entities")
        }
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch {
            print("Failed to save to Core Data \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
}
