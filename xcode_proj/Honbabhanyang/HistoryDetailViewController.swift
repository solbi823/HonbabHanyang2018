//
//  HistoryDetailViewController.swift
//  Honbabhanyang
//
//  Created by hodo on 2018. 6. 6..
//  Copyright © 2018년 hojun. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pID = vcpartyID {
            partyID.text = "\(pID)"
        }
        else {
            partyID.text = "Error 405"
        }
        restaurantName.text = vcrestName
        restaurantPhone.text = vcrestPhone
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
    
    func reportUser() {
        if let UID = Auth.auth().currentUser?.uid {
            // compare with UID and get the different person's UID
            var reportUID: String = ""
            
            // get Firebase Realtime Database reference
            var ref: DatabaseReference!
            ref = Database.database().reference()
            
            // transaction block
            ref.runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
                var dictionary = currentData.value as? [String : Any] ?? [:]
                var reportArray = dictionary["Reports"] as? [String] ?? []
                
                // append report array
                reportArray.append(reportUID)
                
                // apply change
                dictionary["Reports"] = reportArray
                currentData.value = dictionary
                
                // finish transaction
                return TransactionResult.success(withValue: currentData)
            }) { (error, committed, snapshot) in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }

}
