//
//  ProductCell.swift
//  Shopping App
//
//  Created by Raghavendra reddy on 23/12/21.
//

import UIKit

class ProductCell: UITableViewCell {
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    class func identifier ()-> String{
        String(describing: self)
    }
    class func nib() -> UINib{
        UINib(nibName: identifier(), bundle: nil)
    }
    
    var cellViewModel: ProductElement? {
        didSet {
            categoryLabel.text = cellViewModel?.category
            amountLabel.text = "$ \(String(format: "%.2f", cellViewModel?.price ?? 0.0))"
            descriptionLabel.text = cellViewModel?.welcomeDescription
            titleLabel.text = cellViewModel?.title
            
            self.productImage.loadImageFromUrl(urlString: self.cellViewModel?.image ?? "https://socialistmodernism.com/wp-content/uploads/2017/07/placeholder-image.png")
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }
    
    func initView() {
        // Cell view customization
        backgroundColor = .clear
        
        // Line separator full width
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryLabel.text = nil
        amountLabel.text = nil
        descriptionLabel.text = nil
        titleLabel.text = nil
        productImage.image = nil
        
    }
    
}



