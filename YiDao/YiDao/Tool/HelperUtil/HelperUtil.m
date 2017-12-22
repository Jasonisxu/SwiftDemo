//
//  HelperUtil.m
//  SQLite（购物）
//
//  Created by Yock Deng on 15/8/22.
//  Copyright (c) 2015年 蓝桥. All rights reserved.
//

#import "HelperUtil.h"

@implementation HelperUtil

+ (id)toArrayOrNSDictionary:(NSString *)jsonData{
    if (jsonData != nil) {
        NSData* data = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingAllowFragments
                                                          error:nil];
        
        if (jsonObject != nil){
            return jsonObject;
        }else{
            // 解析错误
            return nil;
        }
    }
    return nil;
}

+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}

+(NSString*)parseArrayToStr:(id)arr{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:arr options:kNilOptions error:&error];
    NSString* str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return str;
}

+ (NSString *)distanceTimeWithBeforeTime:(double)beTime
{
    NSTimeInterval now = [[NSDate date]timeIntervalSince1970];
    double distanceTime = now - beTime;
    NSString * distanceStr;
    
    NSDate * beDate = [NSDate dateWithTimeIntervalSince1970:beTime];
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"HH:mm"];
    NSString * timeStr = [df stringFromDate:beDate];
    
    [df setDateFormat:@"dd"];
    NSString * nowDay = [df stringFromDate:[NSDate date]];
    NSString * lastDay = [df stringFromDate:beDate];
    
    if (distanceTime < 60) {//小于一分钟
        distanceStr = @"刚刚";
    }
    else if (distanceTime <60*60) {//时间小于一个小时
        distanceStr = [NSString stringWithFormat:@"%ld分钟前",(long)distanceTime/60];
    }
    else if(distanceTime <24*60*60 && [nowDay integerValue] == [lastDay integerValue]){//时间小于一天
        distanceStr = [NSString stringWithFormat:@"今天 %@",timeStr];
    }
    else if(distanceTime<24*60*60*2 && [nowDay integerValue] != [lastDay integerValue]){
        
        if ([nowDay integerValue] - [lastDay integerValue] ==1 || ([lastDay integerValue] - [nowDay integerValue] > 10 && [nowDay integerValue] == 1)) {
            distanceStr = [NSString stringWithFormat:@"昨天 %@",timeStr];
        }
        else{
            [df setDateFormat:@"MM-dd HH:mm"];
            distanceStr = [df stringFromDate:beDate];
        }
        
    }
    else if(distanceTime <24*60*60*365){
        [df setDateFormat:@"MM-dd"];
        distanceStr = [df stringFromDate:beDate];
    }
    else{
        [df setDateFormat:@"yyyy-MM-dd"];
        distanceStr = [df stringFromDate:beDate];
    }
    return distanceStr;
}
//字符串转化为时间戳
+ (NSString *)stringChangeTimeinterval:(NSString *)strTime {
    NSDateFormatter * df1 = [[NSDateFormatter alloc]init];
    [df1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [df1 dateFromString:strTime];
    NSTimeInterval beTime = [timeDate timeIntervalSince1970];
    NSString *timeStr= [NSString stringWithFormat:@"%.2f",beTime];
    return timeStr;
}

+ (NSString *)distanceTimeWithBeforeTimeForNotice:(NSString *)strTimw
{
    NSDateFormatter * df1 = [[NSDateFormatter alloc]init];
    [df1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [df1 dateFromString:strTimw];
    
    NSTimeInterval now = [[NSDate date]timeIntervalSince1970];
    NSTimeInterval beTime = [timeDate timeIntervalSince1970];
    
    double distanceTime = now - beTime;
    NSString * distanceStr;
    
    NSDate * beDate = [NSDate dateWithTimeIntervalSince1970:beTime];
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"HH:mm"];
    NSString * timeStr = [df stringFromDate:beDate];
    
    [df setDateFormat:@"dd"];
    NSString * nowDay = [df stringFromDate:[NSDate date]];
    NSString * lastDay = [df stringFromDate:beDate];
    
    if (distanceTime < 60) {//小于一分钟
        distanceStr = @"刚刚";
    }
    else if (distanceTime <60*60) {//时间小于一个小时
        distanceStr = [NSString stringWithFormat:@"%ld分钟前",(long)distanceTime/60];
    }
    else if(distanceTime <24*60*60 && [nowDay integerValue] == [lastDay integerValue]){//时间小于一天
        distanceStr = [NSString stringWithFormat:@"今天 %@",timeStr];
    }
    else if(distanceTime<24*60*60*2 && [nowDay integerValue] != [lastDay integerValue]){
        
        if ([nowDay integerValue] - [lastDay integerValue] ==1 || ([lastDay integerValue] - [nowDay integerValue] > 10 && [nowDay integerValue] == 1)) {
            distanceStr = [NSString stringWithFormat:@"昨天 %@",timeStr];
        }
        else{
            [df setDateFormat:@"MM-dd HH:mm"];
            distanceStr = [df stringFromDate:beDate];
        }
        
    }
    else if(distanceTime <24*60*60*365){
        [df setDateFormat:@"MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }
    else{
        [df setDateFormat:@"yyyy-MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }
    return distanceStr;
}

+ (NSString *)orderTimeWithBeforeTime:(NSString *)nowTime
{
    NSDateFormatter * df1 = [[NSDateFormatter alloc]init];
    [df1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [df1 dateFromString:nowTime];
    
    NSTimeInterval now = [[NSDate date]timeIntervalSince1970];
    NSTimeInterval beTime = [timeDate timeIntervalSince1970];
    
    long distanceTime = now - beTime;
    NSString * distanceStr;
    
    NSDate * beDate = [NSDate dateWithTimeIntervalSince1970:beTime];
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"HH:mm"];
    //    NSString * timeStr = [df stringFromDate:beDate];
    
    [df setDateFormat:@"dd"];
    NSString * nowDay = [df stringFromDate:[NSDate date]];
    NSString * lastDay = [df stringFromDate:beDate];
    
    if (distanceTime < 60) {//小于一分钟
        distanceStr = @"刚刚";
    }
    else if (distanceTime <60*60) {//时间小于一个小时
        distanceStr = [NSString stringWithFormat:@"%ld分钟前",(long)distanceTime/60];
    }
    else if(distanceTime <24*60*60 && [nowDay integerValue] == [lastDay integerValue]){//时间小于一天
        long  hoursTimePoor = distanceTime/(60*60);
        distanceStr = [NSString stringWithFormat:@"%d小时前", hoursTimePoor];
    }
    else if(distanceTime <24*60*60*2){
        distanceStr = @"昨天";
    }
    else if(distanceTime <24*60*60*3){
        distanceStr = @"前天";
    }
    else if(distanceTime <24*60*60*30){
        long  hoursTimePoor = distanceTime/(60*60*24);
        distanceStr = [NSString stringWithFormat:@"%ld天前",hoursTimePoor];
        
    }
    else if(distanceTime <24*60*60*365){
        long  hoursTimePoor = distanceTime/(60*60*24*30);
        distanceStr = [NSString stringWithFormat:@"%ld月前",hoursTimePoor];
    }
    else{
        [df setDateFormat:@"yyyy-MM-dd"];
        distanceStr = [df stringFromDate:beDate];
    }
    return distanceStr;
}

+ (NSString *)htmlShuangyinhao:(NSString *)values{
    if (values == nil) {
        return @"";
    }
    /*
     字符串的替换
     注：将字符串中的参数进行替换
     参数1：目标替换值
     参数2：替换成为的值
     参数3：类型为默认：NSLiteralSearch
     参数4：替换的范围
     */
    NSMutableString *temp = [NSMutableString stringWithString:values];
    [temp replaceOccurrencesOfString:@"\"" withString:@"'" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"\r" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    return temp;
}

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor colorWithWhite:1.0 alpha:0.5];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor colorWithWhite:1.0 alpha:0.5];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
//拼接Document目录中的文件路径
+(NSString *)fileByDocumentPath:(NSString *)fileName{
    NSArray *array=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *pathStr=[array objectAtIndex:0];
    return [pathStr stringByAppendingString:fileName];
}

//检查密码的合法性
+ (BOOL)checkPassword:(NSString *)password {
    /*
     1.用一个字符串写入正则表达式
     2.正则表达式的含义是 限定为6到16位的英文大小写字目和数字构成。
     3.这句话的含义是 建立一个谓词，然后这个谓词按照这个正则表达式来要求
     4.最后定义一个bool变量，然后看是否符合正则表达式，来返回是和非。
     */
    
    NSString * pattern = @"^[A-Za-z0-9]{8,20}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    
    BOOL isMatch = [pred evaluateWithObject:password];
    
    return isMatch ;
}
// 时间戳转为字符串的时间
+ (NSString*)timeStamp2Date:(NSString *)timeStamp{
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];//YYYY-
    NSDate* confromTimeSp = [NSDate dateWithTimeIntervalSince1970:[timeStamp doubleValue]];
    NSString* st =[formatter stringFromDate:confromTimeSp];
    return   st;
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

//获取当前屏幕中present出来的viewcontroller。
+ (UIViewController *)getPresentedViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    return topVC;
}



/**
 * 生成GUID
 */
+ (NSString *)generateUuidString{
    // create a new UUID which you own
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    
    // create a new CFStringRef (toll-free bridged to NSString)
    // that you own
    NSString *uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuid));
    
    // transfer ownership of the string
    // to the autorelease pool
    // release the UUID
    CFRelease(uuid);
    
    
    //替换掉某个字符
    uuidString=[uuidString stringByReplacingOccurrencesOfString:@"-"withString:@""];
    
    //字母大写转小写
    NSString *lowerStr = [uuidString lowercaseStringWithLocale:[NSLocale currentLocale]];
    return lowerStr;
}


//字典转Json
+(NSString*)dicToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
//数组转Json
+(NSString*)arrayToJson:(NSMutableArray *)array
{
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//用对象的方法计算文本的大小
+ (CGSize)sizeWithString:(NSString*)str andFont:(UIFont*)font  andMaxSize:(CGSize)size{
    NSDictionary*attrs =@{NSFontAttributeName: font};
    return  [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs  context:nil].size;
}

/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
+ (NSMutableDictionary *)getURLParameters:(NSString *)urlStr {
    
    // 查找参数
    NSRange range = [urlStr rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    // 以字典形式将参数返回
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 截取参数
    NSString *parametersString = [urlStr substringFromIndex:range.location + 1];
    
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            
            id existValue = [params valueForKey:key];
            
            if (existValue != nil) {
                
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                } else {
                    
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
                
            } else {
                
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        
        // 设置值
        [params setValue:value forKey:key];
    }
    
    return params;
}

+ (NSString *)stringWithdrawalForCurrency:(float)currency {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.maximumFractionDigits = 2;
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    formatter.currencySymbol = @"";
    return [formatter stringFromNumber:@(currency)];
}

+ (NSString *)stringForCurrency:(float)currency keepZero:(BOOL)keepZero {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.maximumFractionDigits = 2;
    if (keepZero) {
        formatter.numberStyle = NSNumberFormatterCurrencyStyle;
        formatter.currencySymbol = @"￥";
        return [formatter stringFromNumber:@(currency)];
    } else {
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        return [NSString stringWithFormat:@"￥%@", [formatter stringFromNumber:@(currency)]];
    }
}

+ (void)setLabel:(UILabel *)label withCurrency:(float)currency keepZero:(BOOL)keepZero {
    NSString *str = currency < 0 ? @"未知" : [NSString stringWithFormat:@" %@", [HelperUtil stringForCurrency:currency keepZero:keepZero]];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    UIFont *origFont = label.font;
    CGFloat fontSize = MIN(20.0f, origFont.pointSize / 3 * 2);
    UIFont *font = [label.font fontWithSize:fontSize];
    [attributedString addAttributes:@{ NSFontAttributeName: font, NSKernAttributeName: @( 0 ) }
                              range:[str rangeOfString:@"￥"]];
    if (currency >= 0) {
        CGFloat width = [@" " sizeWithAttributes:@{NSFontAttributeName: origFont}].width;
        [attributedString addAttributes:@{NSKernAttributeName: @(-width)}
                                  range:NSMakeRange(0, 1)];
    }
    label.attributedText = attributedString;
}





//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        NSLog(@"%@",statusBar.backgroundColor);
        statusBar.backgroundColor = color;
    }
}


















@end
