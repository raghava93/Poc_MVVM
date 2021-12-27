//
//  HomeViewModel.swift
//  Shopping App
//
//  Created by Raghavendra reddy on 22/12/21.
//

import Foundation
import RealmSwift

class HomeViewModel{
    
    var productsList:[ProductElement]? = nil
    var networkManager:NetworkManager?
    
//    callbacks for handling UI
    var showError: (()->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?
    
//    initialiser with network manager as dependency
    init(_networkManager:NetworkManager) {
        networkManager = _networkManager
    }
    
    
    //     fetch data from database/API
    func getProducts(completion:@escaping (()->Void))  {
        self.showLoading?()
        //  get product details from DB
        let dbList = ProductDBManager.getProductsFromDB()?.sorted{
            $0.id < $1.id
        }
        if (dbList?.count != 0){
            hideLoading?()
            productsList = dbList
            completion()
        }else{
            //  check for internet connectivity
            if (!Reachability.isConnectedToNetwork()){
                // if offline update product details from DB
                if (dbList?.count != 0){
                    productsList = dbList
                    hideLoading?()
                    completion()
                }else{
                    showError!()
                }
                
            }else{
                // fetch product details from DB
                networkManager?.fetchResponse(url: Urls.productsUrl, httpHeader:.application_json, complete: { [weak self] (success, response) in
                    if success {
                        do {
                            // decode product model from JSON
                            let model = try JSONDecoder().decode(Products.self, from: response!)
                            
                            self!.productsList = model.sorted{
                                $0.id < $1.id
                            }
                            self?.hideLoading?()
                            completion()
                            // store API response to DB
                            let backgroundQueue = DispatchQueue(label: "background",
                                                                qos: .background,
                                                                target: nil)
                            
                            DispatchQueue.main.async {
                                
                                if (dbList != self?.productsList){
                                    ProductDBManager.saveProducts(model: model)
                                }else{
                                    debugPrint("already same data exists")
                                }
                            } // main thread
                        } catch (let fail) {
                            debugPrint("failed model \(fail.localizedDescription)")
                            self?.showError?()
                        }
                    } else {
                        self?.showError?()
                    }
                })
            }
        }
        
    }
    
    // get cell details
    func getCellViewModel(at indexPath: IndexPath) -> ProductElement? {
        
        return productsList?[indexPath.row]
    }
    
    
}

