//
//  Photo.swift
//  CollectionView
//
//  Created by MyMac on 2017/4/10.
//  Copyright © 2017年 Jack Lai. All rights reserved.
//

import Foundation

import Foundation

struct PhotoCategory {
    var categoryImageName: String
    var title: String
    var imageNames: [String]
    
    static func fetchPhotos() -> [PhotoCategory] {
        var categories = [PhotoCategory]()
        let photosData = PhotosLibrary.downloadPhotosData()
        
        for (categoryName, dict) in photosData {
            if let dict = dict as? [String : Any] {
                let categoryImageName = dict["categoryImageName"] as! String
                if let imageNames = dict["imageNames"] as? [String] {
                    let newCategory = PhotoCategory(categoryImageName: categoryImageName, title: categoryName, imageNames: imageNames)
                    categories.append(newCategory)
                }
            }
        }
        
        return categories
    }
}

class PhotosLibrary
{
    class func downloadPhotosData() -> [String : Any]
    {
        return [
            "出生" : [
                "categoryImageName" : "出生",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "a", numberOfImages: 9),
            ],
            "滿月" : [
                "categoryImageName" : "滿月",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "b", numberOfImages: 8),
            ],
            "兩個月" : [
                "categoryImageName" : "兩個月",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "c", numberOfImages: 8),
            ],
            "三個月" : [
                "categoryImageName" : "三個月",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "d", numberOfImages: 9),
            ]
        ]
    }
    
    private class func generateImage(categoryPrefix: String, numberOfImages: Int) -> [String] {
        var imageNames = [String]()
        
        for i in 1...numberOfImages {
            imageNames.append("\(categoryPrefix)\(i)")
        }
        
        return imageNames
    }
}

