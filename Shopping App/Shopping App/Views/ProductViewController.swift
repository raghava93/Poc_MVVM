//
//  ProductViewController.swift
//  Shopping App
//
//  Created by Raghavendra reddy on 23/12/21.
//

import UIKit


class ProductViewController: UIViewController {
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingCountLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    var productModel : ProductElement?

    
//    update UI
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    func updateUI()  {
        priceLabel.text = "$ \(String(format: "%.2f", productModel?.price ?? 0.0))"
        productImage.loadImageFromUrl(urlString: productModel?.image ?? "")
        titleLabel.text = productModel?.title
        ratingLabel.text = "\(String(format: "%.1f", productModel?.rating?.rate ?? 0.0))"
        ratingCountLabel.text = "\(productModel?.rating?.count ?? 0) ratings"
        descriptionLabel.text = productModel?.welcomeDescription
    }
    
}


