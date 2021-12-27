//
//  ProductDBManager.swift
//  Shopping App
//
//  Created by Raghavendra reddy on 25/12/21.
//

import Foundation
import RealmSwift

class ProductDBManager{
    //     fetch from DB
    class func getProductsFromDB() -> [ProductElement]?{
        //                DispatchQueue(label: "background").async {
        autoreleasepool {
            let realm = try! Realm()
            let productResult = realm.objects(ProductElement.self)
            
            let productArray = productResult.toArray(ofType: ProductElement.self)
            return productArray
        }
    }
    
    
    // store to DB
    class func saveProducts(model:[ProductElement]){
        autoreleasepool {
            let realm = try! Realm()
            realm.beginWrite()
            _ = model.map { product in
                realm.add(product)
            }
            try! realm.commitWrite()
        }
    }
    //     clear data from DB
    
    class func deleteProducts(){
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                try! realm.write{
                    realm.deleteAll()
                }
            }
        }
    }
    
    
}

// convert Realm result object into array
extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        
        return array
    }
}
