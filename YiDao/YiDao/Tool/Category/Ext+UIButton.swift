//
//  Ext+UIButton.swift
//  SwiftPractice
//
//  Created by liushaohua on 15/10/22.
//  Copyright © 2015年 liushaohua. All rights reserved.
//

import UIKit

extension UIButton{


    // 遍历构造函数
    /// 创建button
    ///
    /// - parameter setImage:           默认状态图片
    /// - parameter setBackgroundImage: 背景图片
    /// - parameter target:             target
    /// - parameter action:             action
    ///
    /// - returns:
    convenience init(setImage:String,setBackgroundImage:String,target:Any?,action:Selector ){
//        let Btn = UIButton()
        self.init()
        
        self.setImage(UIImage(named:setImage), for: UIControlState.normal)
        self.setImage(UIImage(named:"\(setImage)_highlighted"), for: UIControlState.highlighted)
        self.setBackgroundImage(UIImage(named:setBackgroundImage), for: UIControlState.normal)
        self.setBackgroundImage(UIImage(named:"\(setBackgroundImage)_highlighted"), for: UIControlState.highlighted)
        
        self.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        
        self.sizeToFit()
    }
    
    
    
    /// 返回带文字的图片的按钮
    ///
    /// - parameter setHighlightImage: 背景图片
    /// - parameter title:             文字
    /// - parameter target:            target
    /// - parameter action:            action
    ///
    /// - returns: 
    convenience init(setHighlightImage:String?,title:String?,target:Any?,action:Selector ){
        //        let Btn = UIButton()
        self.init()

        if let img = setHighlightImage {
            self.setImage(UIImage(named:img), for: UIControlState.normal)

            self.setImage(UIImage(named:"\(img)_highlighted"), for: UIControlState.highlighted)
        }
        
        if let tit = title {
            self.setTitle(tit, for: UIControlState.normal)
            self.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
            self.setTitleColor(LLTHEMECOLOR, for: UIControlState.highlighted)
            self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        }
        self.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        
        self.sizeToFit()
        
    }

    convenience init(BackgroundImage:String?,title:String?,titleColor:UIColor, target:Any?,action:Selector ){
        
        self.init()

        self.setBackgroundImage(UIImage(named:BackgroundImage!), for: UIControlState.normal)
        self.setTitle(title, for: UIControlState.normal)
        self.setTitleColor(titleColor, for: UIControlState.normal)
        
        self.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        
        self.sizeToFit()
        
    }
    
    /// 倒计时
    ///
    /// - parameter timeLine: 倒计时总时间
    /// - parameter title: 还没倒计时的title
    /// - parameter mainBGColor: 还没倒计时的背景颜色
    /// - parameter mainTitleColor: 还没倒计时的文字颜色
    /// - parameter countBGColor: 倒计时中的背景颜色
    /// - parameter countTitlecolor: 倒计时中的文字颜色
    /// - parameter handle: 点击按钮的事件
    /// - returns: void
    
    func startTimer( _ timeLine: Int, title: String, mainBGColor: UIColor, mainTitleColor: UIColor, countBGColor: UIColor, countTitleColor: UIColor, handle: (() -> Void)?) {
        var time = timeLine
        // 先创建一个默认队列
        let queue = DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default)
        
        // 再创建一个用户事件 source 倒计时
        let timer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags(rawValue: UInt(0)), queue: queue)
        
        // 把timer设置进去
        /**
         start参数控制计时器第一次触发的时刻。参数类型是 dispatch_time_t，这是一个opaque类型，我们不能直接操作它。我们得需要 dispatch_time 和  dispatch_walltime 函数来创建它们。另外，常量  DISPATCH_TIME_NOW 和 DISPATCH_TIME_FOREVER 通常很有用。
         interval参数没什么好解释的。
         leeway参数比较有意思。这个参数告诉系统我们需要计时器触发的精准程度。所有的计时器都不会保证100%精准，这个参数用来告诉系统你希望系统保证精准的努力程度。如果你希望一个计时器没五秒触发一次，并且越准越好，那么你传递0为参数。另外，如果是一个周期性任务，比如检查email，那么你会希望每十分钟检查一次，但是不用那么精准。所以你可以传入60，告诉系统60秒的误差是可接受的。
         */
        timer.scheduleRepeating(deadline: DispatchTime.now(),
                                
                                interval: .seconds(1),
                                
                                leeway: .seconds(0)
            
        )
        //        timer.setTimer(start: DispatchWallTime(time: nil), interval: 1 * NSEC_PER_SEC, leeway: 0)
        
        // 内建事件
        
        timer.setEventHandler {[weak self] () -> Void in
            if let strongSelf = self {
                if time == 1 {
                    
                    // 只能用这种方式取消
                    timer.cancel()
                    // 刷新UI要回到主线程
                    DispatchQueue.main.async(execute: { () -> Void in
                        
                        
                        strongSelf.backgroundColor = mainBGColor
                        strongSelf.setTitleColor(mainTitleColor, for: UIControlState())
                        strongSelf.setTitle(title, for: UIControlState())
                        strongSelf.isUserInteractionEnabled = true // 这里不要用enable
                        
                    })
                    
                } else {
//                    let content = "重新获取" + "（\((time - 1) % 60)s）"
                    let content = "\((time - 1) % 60)s"

                    DispatchQueue.main.async(execute: { () -> Void in
            
                        strongSelf.backgroundColor = countBGColor
                        strongSelf.setTitleColor(countTitleColor, for: UIControlState())
                        strongSelf.setTitle(content, for: UIControlState())
                        //                    self.titleLabel?.text = content
                        strongSelf.isUserInteractionEnabled = false // 这里不要用enable
                        
                    })
                    
                    
                }
                
            }
            
            time -= 1
            
            
            
        }
        
        // 启动
        timer.resume()
        
        if handle != nil {
            handle!()
        }
        
    }
    

}
