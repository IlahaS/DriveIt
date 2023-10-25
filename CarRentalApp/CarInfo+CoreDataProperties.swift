//
//  CarInfo+CoreDataProperties.swift
//  CarRentalApp
//
//  Created by Ilahe Samedova on 23.10.23.
//
//

import Foundation
import CoreData


extension CarInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CarInfo> {
        return NSFetchRequest<CarInfo>(entityName: "CarInfo")
    }

    @NSManaged public var price: String?
    @NSManaged public var name: String?
    @NSManaged public var engine: String?

}

extension CarInfo : Identifiable {

}
