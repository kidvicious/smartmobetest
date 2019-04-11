//
//  Utils.swift
//  Smartmobe
//
//  Created by Asmin Ghale on 4/11/19.
//  Copyright © 2019 default. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    func downloadImageFrom(link:String, contentMode: UIView.ContentMode, completion: @escaping()->()) {
        if link != ""{
            if let url = URL(string: link){
                
                URLSession.shared.dataTask( with: url, completionHandler: {
                    (data, response, error) -> Void in
                    DispatchQueue.main.async {
                        self.contentMode =  contentMode
                        if let data = data {
                            self.image = UIImage(data: data)
                            completion()
                        }
                    }
                }).resume()
                
            }
        }
    }
}
