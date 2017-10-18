//
//  pch.swift
//  LLProgramFrameworkSwift
//
//  Created by 奥卡姆 on 2017/9/5.
//  Copyright © 2017年 aokamu. All rights reserved.
//

import UIKit

let LLSCREENW = UIScreen.main.bounds.width
let LLSCREENH = UIScreen.main.bounds.height

let LLTHEMECOLOR = UIColor.yellow

// 随机颜色
func LLRandomColor() -> UIColor{
    let r = CGFloat(arc4random()%256)
    let g = CGFloat(arc4random()%256)
    let b = CGFloat(arc4random()%256)
    return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
}

// RGB 颜色值
func RGBCOLOR(r:CGFloat,_ g:CGFloat,_ b:CGFloat) -> UIColor{
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1.0)
}

let LLBigFontSize:    CGFloat = 18
let LLNomalFontSize:  CGFloat = 14
let LLSmallFontSize:  CGFloat = 10

let Main_Color =       RGBCOLOR(r: 240,130,0)
// 自定义打印方法
func printLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
        
        let fileName = (file as NSString).lastPathComponent
        
        print("\(fileName):(\(lineNum)) \(message)")
        
    #endif
}


public let MGDefault = UserDefaults.standard

/****************************通知**********************************/
//登录
let LoginNotification = Notification.Name(rawValue: "LoginNotification")

