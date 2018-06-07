//
//  HistoryDetailViewController.swift
//  Honbabhanyang
//
//  Created by hodo on 2018. 6. 6..
//  Copyright © 2018년 hojun. All rights reserved.
//

import UIKit

class HistoryDetailViewController: UIViewController {
    @IBOutlet weak var partyID: UILabel!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantPhone: UILabel!
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var matchingTime: UILabel!
    
    var partyDetail : Party?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        partyID.text = "\(partyDetail!.partyID)"
        /*                  추가해야할것들을을을으으으을드을을드륻르들
        restaurantName.text =
        restaurantPhone.text =
        user.text =
        matchingTime.text =
         */
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func report(_ sender: Any) {
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
