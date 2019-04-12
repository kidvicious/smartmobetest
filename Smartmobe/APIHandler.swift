//
//  APIHandler.swift
//  Smartmobe
//
//  Created by Asmin Ghale on 4/10/19.
//  Copyright © 2019 default. All rights reserved.
//

import Foundation
import Alamofire

class APIHandler{
    
    static let shared = APIHandler()
    
    func getImages(completion:@escaping(_ data: Any?)->(), failure: @escaping(_ error: Error?)->()){
        let header: HTTPHeaders = [
            "Accept": "Application/json"
        ]
        Alamofire.request(k_api_get_images, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.isSuccess{
                let value = response.result.value
                completion(value)
            }else{
                failure(response.error)
            }
        }
        
    }
    
    func searchImages(query:String, completion:@escaping(_ data: Any?)->(), failure: @escaping(_ error: Error?)->()){
        let header: HTTPHeaders = [
            "Accept": "Application/json"
        ]
        let parameters:Parameters = [
            "query": query
        ]
        
        Alamofire.request(k_api_search, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.isSuccess{
                let value = response.result.value
                completion(value)
            }else{
                failure(response.error)
            }
        }
    }
    
    func getSource(id: Int, completion:@escaping(_ data: Any?)->(), failure: @escaping(_ error: Error?)->()){
        let header: HTTPHeaders = [
            "Accept": "Application/json"
        ]
        
        Alamofire.request(k_api_source(id: id), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.isSuccess{
                let value = response.result.value
                completion(value)
            }else{
                failure(response.error)
            }
        }
    }
    
}
