//
//  RealmData.swift
//  ExampleSchoolSearchApp
//
//  Created by uejo on 2020/05/14.
//  Copyright © 2020 uejo. All rights reserved.
//

import Foundation
import RealmSwift

//Realmへと格納するためのオブジェクトを作成
class RealmItemData55: Object {
    @objc dynamic var itemName: String?
    @objc dynamic var itemCaption: String?
    @objc dynamic var itemImage: String?
    @objc dynamic var itemUrl: String?
    @objc dynamic var itemPrice = 0
    
////    //プライマリキーを設定
    override static func primaryKey() -> String? {
        return "itemName"
    }

}
