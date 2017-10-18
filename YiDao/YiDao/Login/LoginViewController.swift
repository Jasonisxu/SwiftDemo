//
//  LoginViewController.swift
//  YiDao
//
//  Created by Wicrenet_Jason on 2017/10/12.
//  Copyright © 2017年 Wicrenet_Jason. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var tfPhoneNuber: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btCode: UIButton!
    @IBOutlet weak var btLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addTextFieldLeftViewwAction()
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFiledNotifitionAction), name: NSNotification.Name.UITextFieldTextDidChange, object: nil);

    }
    
    // MARK:
    func addTextFieldLeftViewwAction() {
        let leftView0 = UIView.init(frame: CGRect(x:0, y:0, width:40, height:45))
        let imageView0 = UIImageView.init(imgName: "icon-back-number")
        imageView0.frame =  CGRect(x:0, y:0, width:20, height:20)
        leftView0.addSubview(imageView0)
        imageView0.center = CGPoint(x: (leftView0.center.x + 5),y: leftView0.center.y)
        
        let leftView1 = UIView.init(frame: leftView0.frame)
        let imageView1 = UIImageView.init(imgName: "icon-back-code")
        imageView1.frame =  imageView0.frame
        leftView1.addSubview(imageView1)
        imageView1.center = imageView0.center
        
        tfPhoneNuber.leftView = leftView0
        tfPhoneNuber.leftViewMode = .always
        tfPassword.leftView = leftView1
        tfPassword.leftViewMode = .always

    }
    
    // MARK: 输入限制
    @objc func textFiledNotifitionAction(userInfo:NSNotification){

        let textField = userInfo.object as! UITextField
        
        if textField.tag == 0 {
            let phoneStr = tfPhoneNuber.text! as NSString
            if (phoneStr.length >= 11) {
                tfPhoneNuber.text = phoneStr.substring(to: 11);
            }
        }
        
        if textField.tag == 1 {
            let pwdStr = tfPassword.text! as NSString
            if (pwdStr.length >= 6) {
                tfPassword.text = pwdStr.substring(to: 6);
            }
        }
        
    }
    
    // MARK: 获取验证码
    @IBAction func loginGetCodeAction(_ sender: UIButton) {

        if !validatePhone(tfPhoneNuber.text,tips:"请输入正确的手机号",is_phone:true){
            return
        }
        
        requestCodeAction()
    }
    
    // MARK: 验证码登录
    @IBAction func loginPWDAction(_ sender: UIButton) {
        
        if !validatePhone(tfPhoneNuber.text,tips:"请输入正确的手机号",is_phone:true){
            return
        }
            
        if !validatePhone(tfPassword.text,tips:"请输入正确的验证码"){
            return
        }
     
        requestLoginAction()
    }
    
    fileprivate func validatePhone(_ phoneNumber:String?,tips:String,is_phone:Bool = false) -> Bool{
        guard let phone = phoneNumber , phone.count != 0 else{
            LLProgressHUD.showInfo(tips)
            return false
        }
        
        if is_phone {
            guard tfPhoneNuber.text! =~ isIphoneNum else{
                LLProgressHUD.showInfo(tips)
                return false
            }
        }
       
        return true
    }
    
    func requestCodeAction() {
        let mobile = tfPhoneNuber.text ?? ""
        NetAPIManager.sharedManager.requestWithTarget(.api_LoginCode(mobile: mobile), successClosure: {[weak self] (result, code) in
            if let strongSelf = self{
             strongSelf.btCode.startTimer(60, title: "重新获取", mainBGColor: .clear, mainTitleColor: Main_Color, countBGColor: .clear, countTitleColor: Main_Color, handle: nil)
            }
        }) { (errorMsg) in
            
        }
    }
    
    func requestLoginAction() {
        let mobile = tfPhoneNuber.text ?? ""
        let code = tfPassword.text ?? ""

        NetAPIManager.sharedManager.requestWithTarget(.api_Login(mobile: mobile, code: code), successClosure: {[weak self] (result, code) in
            if let strongSelf = self{
                
                if let userInfo = UserInfo.deserialize(from: (result as! Dictionary)) {
                    UserManager.saveUserInfo(userInfo)
                    NotificationCenter.default.post(name: LoginNotification, object: nil)
                    
                }
            }
        }) { (errorMsg) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


