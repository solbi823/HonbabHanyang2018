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
    var partyDate : String? = ""
    let restaurantList:[Restaurant] = RestaurantData().restaurants
    
    override func viewDidLoad() {
        super.viewDidLoad()
        partyID.text = "\(partyDetail!.partyID)"
        restaurantList.map({
            if($0.name == partyDetail?.menu) {
                restaurantName.text = $0.name
                restaurantPhone.text = $0.phoneNumber
                //user.text =
                //matchingTime.text =
            }
        })
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
