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
    
    //var partyDetail : Party?
    var vcpartyDate : String?
    var vcpartyID : Int?
    var vcpartyMaxPeople : Int?
    var vcpartyMenu : String?
    var vcrestName : String?
    var vcrestPhone : String?
    var vcrestGenre : String?
    var vcrestRegion : String?
    var vcuser1 : String?
    var vcuser2 : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pID = vcpartyID {
            partyID.text = "\(pID)"
        }
        else {
            partyID.text = "Error 405"
        }
        restaurantName.text = vcuser2
        restaurantPhone.text = vcuser1
        matchingTime.text = vcpartyDate
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
