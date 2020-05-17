//
//  ItemData.swift
//  ExampleSchoolSearchApp
//
//  Created by uejo on 2020/05/14.
//  Copyright © 2020 uejo. All rights reserved.
//

import Foundation

//検索結果全体を格納するクラス
class ResultGet: Codable {
   var items: [OneItem]
    
    private enum CodingKeys: String, CodingKey {
        case items = "Items"
        
    }
}

//検索結果のセット（もう一つのネスト分）を格納するクラス
class OneItem: Codable {
   var item: Item
    
    private enum CodingKeys: String, CodingKey {
        case item = "Item"
    }
}

//ひとつのアイテムを格納するクラス
class Item: Codable {
    var mediumImageUrls: [ImageUrl]?
    var smallImageUrls: [ImageUrl]?
    var itemCaption: String?
    var itemName: String
    var itemPrice: Int
    var itemUrl: URL?
}

class ImageUrl: Codable {
    var imageUrl: URL?
}

