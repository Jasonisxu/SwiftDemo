//
//  HomeViewController.swift
//  YiDao
//
//  Created by Wicrenet_Jason on 2017/10/17.
//  Copyright © 2017年 Wicrenet_Jason. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
  
    }

    @IBAction func logout(_ sender: UIButton) {
        UserManager.exitLogin()
        NotificationCenter.default.post(name: LoginNotification, object: nil)
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
