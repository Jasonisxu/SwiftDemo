//
//  HelperUtil.h
//  SQLite（购物）
//
//  Created by Yock Deng on 15/8/22.
//  Copyright (c) 2015年 蓝桥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HelperUtil : NSObject
//将JSON串转化为字典或者数组
+ (id)toArrayOrNSDictionary:(NSString *)jsonData;

+ (NSString *)htmlShuangyinhao:(NSString *)values;

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;
// 字符串转为字典
+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString ;

//数组转为字符串
+(NSString*)parseArrayToStr:(id)arr;

//拼接Document目录中的文件路径
+(NSString *)fileByDocumentPath:(NSString *)fileName;

+ (NSString *)distanceTimeWithBeforeTime:(double)beTime;
// 时间戳转为字符串的时间
+ (NSString*)timeStamp2Date:(NSString*)timeStamp;
+ (NSString *)distanceTimeWithBeforeTimeForNotice:(NSString *)strTimw;

//下单时间
+ (NSString *)orderTimeWithBeforeTime:(NSString *)nowTime;

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC;
//获取当前屏幕中present出来的viewcontroller。
+ (UIViewController *)getPresentedViewController;

/**
 * 生成GUID
 */
+ (NSString *)generateUuidString;

//字典转Json
+(NSString*)dicToJson:(NSDictionary *)dic;

//数组转Json
+(NSString*)arrayToJson:(NSMutableArray *)array;

//字符串转化为时间戳
+ (NSString *)stringChangeTimeinterval:(NSString *)strTime;

//用对象的方法计算文本的大小
+ (CGSize)sizeWithString:(NSString*)str andFont:(UIFont*)font  andMaxSize:(CGSize)size;

/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
+ (NSMutableDictionary *)getURLParameters:(NSString *)urlStr;

// 格式化货币
+ (NSString *)stringForCurrency:(float)currency keepZero:(BOOL)keepZero;

// 将货币格式化，并设置给UILabel
+ (void)setLabel:(UILabel *)label withCurrency:(float)currency keepZero:(BOOL)keepZero;

- (void)setStatusBarBackgroundColor:(UIColor *)color;

+ (NSString *)stringWithdrawalForCurrency:(float)currency;

@end
