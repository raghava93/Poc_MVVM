//
//  Product+CoreDataProperties.swift
//  Shopping App
//
//  Created by Raghavendra reddy on 24/12/21.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var price: Double
    @NSManaged public var welcomeDescription: String?
    @NSManaged public var productRating: ProductRating?

}

extension Product : Identifiable {

}
