//
//  Media.swift
//  Smartmobe
//
//  Created by Asmin Ghale on 4/10/19.
//  Copyright © 2019 default. All rights reserved.
//

import Foundation

class Media{
    
    class func parseResult(data: NSDictionary) -> [MediaResult]{
        var media = [MediaResult]()
        if let imagesDict = data.value(forKey: "images") as? NSArray{
            for each in imagesDict{
                let imageDict = each as! NSDictionary
                let id = imageDict.value(forKey: "id") as? Int
                let largeURL = imageDict.value(forKey: "large_url") as? String
                let sourceID = imageDict.value(forKey: "source_id") as? String
                let url = imageDict.value(forKey: "url") as? String
                let copyright = imageDict.value(forKey: "copyright") as? String
                let site = imageDict.value(forKey: "site") as? String
                media.append(MediaResult(id: id, largeURL: largeURL, sourceID: sourceID, url: url, copyright: copyright, site: site))
            }
        }
        return media
    }
}

struct MediaResult{
    var id: Int?
    var largeURL: String?
    var sourceID:String?
    var url:String?
    var copyright: String?
    var site: String?
}
