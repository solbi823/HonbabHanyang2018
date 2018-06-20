//
//  JoinViewController.swift
//  Honbabhanyang
//
//  Created by 최솔비 on 2018. 5. 24..
//  Copyright © 2018년 hojun. All rights reserved.
//

import UIKit
import Firebase

class JoinViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.isSecureTextEntry = true
        passwordCheckTextField.isSecureTextEntry = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tryJoining(_ sender: Any) {
        let email: String = emailTextField.text ?? "";
        let password: String = passwordTextField.text ?? "";
        let passwordCheck: String = passwordCheckTextField.text ?? "";
        
        // email is not in the form of "name@hanyang.ac.kr"
        if email.suffix(14) != "@hanyang.ac.kr" {
            let alert = UIAlertController(title : "한양 이메일이 아니에요!", message : "이메일을 \"name@hanyang.ac.kr\"의 형식으로 해주세요", preferredStyle : UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title : "확인", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true , completion: nil)
            return;
        }
        
        // check if password is equal to passwordCheck
        if password != passwordCheck {
            let alert = UIAlertController(title : "비밀번호가 달라요", message : "비밀번호 확인 필드를 확인해주세요", preferredStyle : UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title : "확인", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true , completion: nil)
            return;
        }
        
        // check if password is entered
        if password.count == 0 {
            let alert = UIAlertController(title : "비밀번호를 입력해주세요", message : "", preferredStyle : UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title : "확인", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true , completion: nil)
            return;
        }
        
        // join
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
        }
        let _ = navigationController?.popViewController(animated: true)
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
