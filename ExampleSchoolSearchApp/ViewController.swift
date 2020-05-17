//
//  ViewController.swift
//  ExampleSchoolSearchApp
//
//  Created by uejo on 2020/05/14.
//  Copyright © 2020 uejo. All rights reserved.
//

import UIKit
import Moya
import RealmSwift

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    var itemImages = NSCache<AnyObject, UIImage>()
    var itemDataArray: [Results<RealmItemData55>]?
    
    @IBOutlet weak var homeSearchBar: UISearchBar!
    @IBOutlet weak var recentlyCollectionView: UICollectionView!
    @IBOutlet weak var attentionCollectionView: UICollectionView!
    
    @IBOutlet weak var areaSearchButton: UIButton!
    @IBOutlet weak var timeSearchButton: UIButton!
    @IBOutlet weak var placeSearchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //デリゲートの設定
        recentlyCollectionView.delegate = self
        attentionCollectionView.delegate = self
        homeSearchBar.delegate = self
        
        //ボタンを2行にする処理
        areaSearchButton.titleLabel?.numberOfLines = 0
        timeSearchButton.titleLabel?.numberOfLines = 0
        placeSearchButton.titleLabel?.numberOfLines = 0
        
        //URLのセッション処理
        let provider = MoyaProvider<RakutenAPI>()
                        provider.request(.search(request: ["applicationId":"1052191147129355879", "keyword":"スマホ", "sort":"+updateTimestamp", "hits":"5", "page":"1"])) { result in
                            switch result {
                            case let .success(moyaResponse):
                                let jsonData = try? JSONDecoder().decode(ResultGet.self, from: moyaResponse.data)
                                
                                //オブジェクトの有無を確認
                                if jsonData != nil {
                                    
                                    //5つだけデータを取ってくる
                                    for count in 0...4 {
                                        
                                        //realmのセットアップ
                                        let realm = try! Realm()
                                        print(realm.configuration.fileURL!)
                                        
                                        let realmData = RealmItemData55()
                                        
                                        //Realmに保存するためのオブジェクトに情報を追加
                                        realmData.itemName = jsonData!.items[count].item.itemName
                                        realmData.itemCaption = jsonData!.items[count].item.itemCaption
                                        realmData.itemPrice = jsonData!.items[count].item.itemPrice
                                        
                                        //imageUrlとitemUrlはString型に変換してから格納
                                        realmData.itemImage = jsonData!.items[count].item.smallImageUrls?.first?.imageUrl?.absoluteString
                                        realmData.itemUrl = jsonData!.items[count].item.itemUrl?.absoluteString
                                        
                                        //realmデータベースに情報を格納
                                        try! realm.write {
                                            realm.add(realmData, update: .all)
                                                                                
                                        }
                                        
                                    }
                                    
                                    //「革」という名前が入るものだけを検索
                                    let realm = try! Realm()
                                    let result = realm.objects(RealmItemData55.self).filter("itemName contains 'スマホ'")
                                    
                                    
                                    var name: String?
                                    var image: String?
                                    
                                    for data in result {
                                        name = data.itemName
                                        image = data.itemImage
                                    }
                                    
                                    print("\(name!)")
                                    print("\(image!)")
                                    
                                    
                                    
                                    //Jsonへの格納は成功
                                    print("jsonに格納完了！")
                                    //jsonへの格納が失敗
                                } else {
                                    print("jsonDataはなしです")
                                }
                
                                //そもそもアクセスそのものが失敗
                            case let .failure(error):
                                print("アクセスに失敗しました:\(error)")
                            }
                        }
        
    }
    
    
    
    //URLからUIImageを作成するための処理
    func getImageFromUrl(url: String) -> UIImage {
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            return UIImage(data: data)!
        } catch let error {
            print("エラーですよ\(error.localizedDescription)")
        }
        return UIImage()
    }
    
    //collectionViewが押されたときの処理
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("押されたよ")
    }
    
    //collectionViewの個数を返す処理
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    //collectionViewの中身を返す処理
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recentCell", for: indexPath)
        
        return cell
        
    }


}

