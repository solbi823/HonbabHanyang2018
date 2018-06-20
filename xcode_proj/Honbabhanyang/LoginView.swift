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
        
        PasswordView.isSecureTextEntry = true

        // already logged in
        if let _ = Auth.auth().currentUser {
            
            // move to main navigation
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainNavigationController") as! UINavigationController
            self.present(newViewController, animated: true, completion: nil)
            
            EmailView.placeholder = "이미 로그인 된 상태입니다."
            PasswordView.placeholder = "이미 로그인 된 상태입니다."
            LoginButtonView.setTitle("이미 로그인 된 상태입니다.", for: .normal)
        }
    }
    
    @IBAction func loginButtonTouched(_ sender :Any){
        Auth.auth().signIn(withEmail: EmailView.text!, password : PasswordView.text!){
            
            (user, error) in
            
            if user != nil{
                print("로그인 성공")
                // move to main navigation
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainNavigationController") as! UINavigationController
                self.present(newViewController, animated: true, completion: nil)
            }
            else {
                let alert = UIAlertController(title : "로그인 실패", message : "다시 시도해주세요", preferredStyle : UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title : "확인", style: UIAlertActionStyle.default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true , completion: nil)
            }
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
