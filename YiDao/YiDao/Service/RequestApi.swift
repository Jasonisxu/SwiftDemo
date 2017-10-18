//
//  RequestApi.swift
//  YiDao
//
//  Created by Wicrenet_Jason on 2017/10/16.
//  Copyright © 2017年 Wicrenet_Jason. All rights reserved.
//

import Moya
import SwiftyJSON

//请求分类
public enum RequestApi{
    
    static var HostUrl:String! = BaseUrl + MAIN_URL
    
    case api_Test
    case api_LoginCode(mobile: String)
    case api_Login(mobile: String, code: String)
    
}

//请求配置
extension RequestApi: TargetType {
    //服务器地址
    public var baseURL: URL {
        return URL(string: RequestApi.HostUrl)!
    }
    
    //各个请求的具体路径
    public var path: String {
        switch self {
        case .api_Test:
            return URL_Test
            
        case .api_LoginCode:
            return URL_LoginCode
        case .api_Login:
            return URL_Login
            
            
        }
    }
    
    //请求类型
    public var method: Moya.Method {
        switch self {
        case .api_Test:
            return .get
            
        default:
            return .post
        }
        
    }
    
    //请求任务事件（这里附带上参数）
    public var task: Task {
        var params = [String: Any]()
        
        switch self {
            
        case let .api_LoginCode(mobile):
            params = ["mobile": mobile]
        case let .api_Login(mobile,code):
            params = ["mobile": mobile,"code": code]
            
        default:
            return .requestPlain
        }
        
        return .requestParameters(parameters: params,
                                  encoding: URLEncoding.default)
        
    }
    
    /// 返回""空串的话代表需要在回调函数里面自己提示
    public var endSuccessMsg:String?{
        switch self {
        case .api_LoginCode:
            return "发送成功"
        case .api_Login:
            return "登录成功"
  
        default:
            return ""
        }
    }
    
    //是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
    
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    //请求头
    public var headers: [String: String]? {
        return nil
    }
}

