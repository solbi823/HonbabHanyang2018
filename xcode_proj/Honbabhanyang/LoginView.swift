//
//  LoginView.swift
//  Honbabhanyang
//
//  Created by 최솔비 on 2018. 5. 22..
//  Copyright © 2018년 hojun. All rights reserved.
//

import UIKit
import Firebase

class LoginView: UIViewController {

    @IBOutlet weak var EmailView: UITextField!
    @IBOutlet weak var PasswordView: UITextField!
    @IBOutlet weak var LoginButtonView: UIButton!
    @IBOutlet weak var NewAccountView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoginButtonView.layer.cornerRadius = 4

        if let user = Auth.auth().currentUser {
            
            EmailView.placeholder = "이미 로그인 된 상태입니다."
            
            PasswordView.placeholder = "이미 로그인 된 상태입니다."
            
            LoginButtonView.setTitle("이미 로그인 된 상태입니다.", for: .normal)
            
    }
    
    func loginButtonTouched(_ sender :Any){
        
        Auth.auth().signIn(withEmail: EmailView.text!, password : PasswordView.text!){
            
            (user, error) in
            
            if user != nil{
                print("로그인 성공")
            }
            else {
                print("로그인 실패")
            }
        }
        
    }

    func didReceiveMemoryWarning() {
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
}
