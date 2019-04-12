//
//  Constant.swift
//  Smartmobe
//
//  Created by Asmin Ghale on 4/10/19.
//  Copyright © 2019 default. All rights reserved.
//

import Foundation

let k_api_root = "http://www.splashbase.co"

let k_api_get_images = "\(k_api_root)/api/v1/images/latest"
///params : 'query': <search query>
let k_api_search = "\(k_api_root)/api/v1/images/search"

func k_api_source(id: Int) -> String{
    return "\(k_api_root)/api/v1/sources/:\(id)"
}

