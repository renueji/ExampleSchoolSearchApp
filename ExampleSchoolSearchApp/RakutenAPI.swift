//
//  RakutenAPI.swift
//  ExampleSchoolSearchApp
//
//  Created by uejo on 2020/05/14.
//  Copyright © 2020 uejo. All rights reserved.
//

import Foundation
import Moya

enum RakutenAPI {
    case search(request: Dictionary<String, Any>)
}

//拡張
extension RakutenAPI: TargetType {
    //呼び出すAPIのURL
    var baseURL: URL {
        return URL(string: "https://app.rakuten.co.jp/services/api/IchibaItem/Search")!
    }
    
    //APIのパスを書く
    var path: String {
        switch self {
        case .search:
            return "/20170706"
        }
    }
    
    //apiのメソッドを書く
    var method: Moya.Method {
        return .get
    }
    
    //サンプルデータを記載
    var sampleData: Data {
        return Data()
    }
    
    //APIで何を送りたいかを書く
    var task: Task {
        switch self {
        case .search(let request):
            return .requestParameters(parameters: request, encoding: URLEncoding.default)
        }
    }
    
    //リクエストヘッダの設定
    var headers: [String : String]? {
        return ["components-type":"application/json"]
    }
    
    
}
