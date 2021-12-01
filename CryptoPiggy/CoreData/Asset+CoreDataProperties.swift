//
//  Asset+CoreDataProperties.swift
//  CryptoPiggy
//
//  Created by Paweł Brzozowski on 01/12/2021.
//
//

import Foundation
import CoreData


extension Asset {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Asset> {
        return NSFetchRequest<Asset>(entityName: "Asset")
    }

    @NSManaged public var name: String?
    @NSManaged public var quantity: Double

}

extension Asset : Identifiable {

}
