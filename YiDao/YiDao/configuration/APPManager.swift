//
//  APPManager.swift
//  YiDao
//
//  Created by Wicrenet_Jason on 2017/12/22.
//  Copyright © 2017年 Wicrenet_Jason. All rights reserved.
//

import Foundation

struct APPManager {
    
    static let MainColorString            = "MainColorString"
    
    static var MainColorString_Value: String {
        get{
            return (MGDefault.object(forKey: MainColorString) as? String) ?? ""
        }
        set{
            MGDefault.set(newValue, forKey: MainColorString)
            MGDefault.synchronize()
        }
    }
    
    static func saveAppManagerData(){
        
        let filePath = Bundle.main.path(forResource: "APPSetting", ofType: "plist")
        let dataDic = NSDictionary.init(contentsOfFile: filePath!)
        
        MGDefault.set(dataDic![MainColorString], forKey:MainColorString)
        
        MGDefault.synchronize()
    }
    
    static func cleanUserInfo(){
        MGDefault.set(nil, forKey:MainColorString)
        
        MGDefault.synchronize()
    }
    
//    func appManagerData() -> Dictionary<String,String>{
//        let filePath = Bundle.main.path(forResource: "APPSetting", ofType: "plist")
//        let dataDic = NSDictionary.init(contentsOfFile: filePath!)
//        return dataDic as! Dictionary<String, String>
//    }
    
}
