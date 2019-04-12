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
        request(url: k_api_get_images, completion: { (response) in
            completion(response)
        }) { (error) in
            failure(error)
        }
    }
    
    func searchImages(query:String, completion:@escaping(_ data: Any?)->(), failure: @escaping(_ error: Error?)->()){
        request(url: k_api_search(query: query), completion: { (response) in
            completion(response)
        }) { (error) in
            failure(error)
        }
    }
    
    func getSource(id: Int, completion:@escaping(_ data: Any?)->(), failure: @escaping(_ error: Error?)->()){
        request(url: k_api_source(id: id), completion: { (response) in
            completion(response)
        }) { (error) in
            failure(error)
        }
    }
    
    fileprivate func request(url: String, completion:@escaping(_ data: Any?)->(), failure: @escaping(_ error: Error?)->()){
        let header: HTTPHeaders = [
            "Accept": "Application/json"
        ]
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.isSuccess{
                let value = response.result.value
                completion(value)
            }else{
                failure(response.error)
            }
        }
    }
}
