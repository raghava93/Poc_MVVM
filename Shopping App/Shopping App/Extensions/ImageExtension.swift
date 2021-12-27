//
//  ImageExtension.swift
//  Shopping App
//
//  Created by Raghavendra reddy on 23/12/21.
//

import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    
    func loadImageFromUrl(urlString: String)   {
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = imageFromCache
            return
        }
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        imageCache.setObject(image, forKey: urlString as NSString)
                        self?.image = image
                    }
                    
                }
            }
        }
        
    }
    
}
