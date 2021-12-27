//
//  ProductModel.swift
//  Shopping App
//
//  Created by Raghavendra reddy on 22/12/21.
//

import Foundation
import RealmSwift

// MARK: - WelcomeElement
class ProductElement: Object, Codable, ObjectKeyIdentifiable {
    @objc dynamic var id: Int
    @objc dynamic var title: String
    @objc dynamic var price: Double
    @objc dynamic var welcomeDescription: String
    @objc dynamic var category: String
    @objc dynamic var image: String
    @objc dynamic var rating: Rating?
    
    enum CodingKeys: String, CodingKey {
        case id, title, price
        case welcomeDescription = "description"
        case category, image, rating
    }
    
}

// MARK: - Rating
class Rating: Object, Codable, ObjectKeyIdentifiable {
    @objc dynamic var rate: Double
    @objc dynamic var count: Int
}

typealias Products = [ProductElement]
