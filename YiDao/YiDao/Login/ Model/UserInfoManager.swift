//
//  UserInfoModel.swift
//  YiDao
//
//  Created by Wicrenet_Jason on 2017/10/17.
//  Copyright © 2017年 Wicrenet_Jason. All rights reserved.
//

import Foundation
import HandyJSON

class UserInfo: HandyJSON {
    var id: String?
    
    var status: Int = 0
    
    var totalAmount: Int = 0
    
    var sex: Int = 0
    
    var preSendOrderCount: Int = 0
    
    var favoriteCount: Int = 0
    
    var buyNumber: Int = 0
    
    var infoCompleted: Bool = false
    
    var questionMsgCount: Int = 0
    
    var createTime: String?
    
    var unPayOrderCount: Int = 0
    
    var preReceiveOrderCount: Int = 0
    
    var completedOrderCount: Int = 0
    
    var lastModifyTime: String?
    
    var preReviewOrderCount: Int = 0
    
    var score: Int = 0
    
    var receiveMsgCount: Int = 0
    
    var name: String?
    
    required init() {}
    
}

struct UserManager {
    static let user_id            = "user_id"

    static var id: String {
        get{
            return (MGDefault.object(forKey: user_id) as? String) ?? ""
        }
        set{
            MGDefault.set(newValue, forKey: user_id)
            MGDefault.synchronize()
        }
    }
    
    static func saveUserInfo(_ model:UserInfo?){
        MGDefault.set(model?.id, forKey:user_id)
      
        MGDefault.synchronize()
    }
    
    static func cleanUserInfo(){
        MGDefault.set(nil, forKey:user_id)
        
        MGDefault.synchronize()
    }
    /**
     退出登录
     清空用户的各个信息
     */
    static func exitLogin(){
        cleanUserInfo()
    }
    
}
