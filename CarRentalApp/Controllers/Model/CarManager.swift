//
//  CarManager.swift
//  CarRentalApp
//
//  Created by Ilahe Samedova on 27.10.23.
//

import Foundation
import RealmSwift

enum CarType: String, CaseIterable {
    case standard = "Standard"
    case prestige = "Prestige"
    case suv = "SUV"
}

class CarManager: Object{
    
    @Persisted var name: String?
    @Persisted var model: String?
    @Persisted var type: String = CarType.standard.rawValue
    @Persisted var engine: String?
    @Persisted var price: String?
}
