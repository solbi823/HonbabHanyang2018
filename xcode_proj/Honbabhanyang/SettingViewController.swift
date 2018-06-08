//
//  SettingViewController.swift
//  Honbabhanyang
//
//  Created by hodo on 2018. 6. 7..
//  Copyright © 2018년 hojun. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var autoLoginSwitch: UISwitch!
    @IBOutlet weak var pushAlarmSwitch: UISwitch!
    let setting = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //autoLoginSwitch.isOn =
        pushAlarmSwitch.isOn = setting.bool(forKey: "pushAlarm")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func pushAlarm(_ sender: Any) {
        let isOn = !(setting.bool(forKey: "pushAlarm"))
        setting.set(isOn, forKey: "pushAlarm")
        pushAlarmSwitch.isOn = setting.bool(forKey: "pushAlarm")
    }
    @IBAction func autoLogin(_ sender: Any) {
    }
    @IBAction func logOut(_ sender: Any) {
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
