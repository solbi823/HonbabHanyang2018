//
//  SettingViewController.swift
//  Honbabhanyang
//
//  Created by hodo on 2018. 6. 7..
//  Copyright © 2018년 hojun. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var pushAlarmSwitch: UISwitch!
    let setting = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    @IBAction func logOut(_ sender: Any) {
        let forReset = Party(menu: "for reset", maxPeople: 0)
        let data = HistoryCenter(_party: forReset)
        data.reset()
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

/* 1초 후 알람
 override func viewDidLoad() {
 super.viewDidLoad()
 UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,], completionHandler: {didAllow,Error in })
 // UNUserNotificationCenter.current().delegate = self as! UNUserNotificationCenterDelegate
 // Do any additional setup after loading the view, typically from a nib.
 }
 
 @IBAction func makeButton(_ sender: Any) {
 let alarmContent = UNMutableNotificationContent()
 alarmContent.title = "혼밥하냥"
 alarmContent.body = "매칭이 완료되었습니다! 지금 바로 확인!"
 let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
 let request = UNNotificationRequest(identifier: "timerdone", content: alarmContent, trigger: trigger)
 UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
 }
 */
 
 
