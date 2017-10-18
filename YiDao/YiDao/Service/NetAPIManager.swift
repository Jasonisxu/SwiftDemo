
import Moya
import SwiftyJSON
import HandyJSON

typealias FailClosure               = (_ errorMsg:String?) -> ()
typealias SuccessClosure            = (_ result:AnyObject, _ code: String?) ->()

enum RequestCode:String{
    case FailError = "-1"
    case Success = "0"      //数据请求成功
}

//MARK:前后端约定的返回数据结构
class ReturnInfo: HandyJSON {
    var result:AnyObject? //若返回无数据，returnObject字段也得带上,可为空值
    var code: String?
    var msg: String?
    required init() {}
}


class NetAPIManager {
    static let sharedManager = NetAPIManager()
    fileprivate init(){}
    
    let requestProvider = MoyaProvider<RequestApi>()
    
    func requestWithTarget(
        _ target:RequestApi,
        successClosure:@escaping SuccessClosure,
        failClosure:@escaping FailClosure
        ){
        
        LLProgressHUD.showLoading("Loading...")
        print("\n request target 请求的URL：\(target.baseURL)\(target.path) \n请求的参数\(target.task)")
        _ =  requestProvider.request(target) { (result) in
            
            switch result{
                
            case let .success(response):
                
                _ = response.data
                _ = response.statusCode
                
                let jsonString      = try! response.mapString()
                let info = ReturnInfo.deserialize(from: jsonString)
                printLog("response resCode:\(info?.code) resMsg:\(info?.msg) data:\(info?.result)")
                
                if let code = info?.code{
                    
                    guard code == RequestCode.Success.rawValue else{
                        LLProgressHUD.showInfo((info?.msg)!)
                        failClosure(info?.msg)
                        return
                    }
                    
                }else{
                    LLProgressHUD.showInfo("网络错误")
                    failClosure("网络错误")
                    return
                }
                
                if let endMsg = target.endSuccessMsg{
                    if endMsg == ""{
                        LLProgressHUD.dismissHUD()
                    }else{
                        LLProgressHUD.showSuccess(endMsg)
                    }
                }else{
                    LLProgressHUD.dismissHUD()
                }
                
                let res = info?.result ?? [] as AnyObject
                successClosure(res, info?.code)
                
            case let .failure(error):
                print("error:\(error)")
                LLProgressHUD.showInfo("网络错误")
                failClosure("网络错误")
                break
            }
        }
    }
}

