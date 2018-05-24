//
//  FirstView.swift
//  Honbabhanyang
//
//  Created by 최솔비 on 2018. 5. 22..
//  Copyright © 2018년 hojun. All rights reserved.
//

import UIKit
import Firebase

class FirstView: UIViewController {

    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var JoinButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginButton.layer.cornerRadius = 4
        JoinButton.layer.cornerRadius = 4

        // Do any additional setup after loading the view.
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
