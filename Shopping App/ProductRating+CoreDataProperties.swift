//
//  ProductRating+CoreDataProperties.swift
//  Shopping App
//
//  Created by Raghavendra reddy on 24/12/21.
//
//

import Foundation
import CoreData


extension ProductRating {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductRating> {
        return NSFetchRequest<ProductRating>(entityName: "ProductRating")
    }

    @NSManaged public var rate: Double
    @NSManaged public var count: Int64

}
