//
//  RestaurantInfoViewController.swift
//  Honbabhanyang
//
//  Created by hojun on 30/05/2018.
//  Copyright © 2018 hojun. All rights reserved.
//

import UIKit
import FirebaseDatabase

class RestaurantInfoViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
    var restaurant: Restaurant?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let rest = restaurant {
            name.text = rest.name
            region.text = "\(rest.region)"
            genre.text = "\(rest.genre)"
            phoneNumber.text = rest.phoneNumber
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // try to join party
    func runTransaction(action: UIAlertAction) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        // transaction block
        ref.runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
            var dictionary = currentData.value as? [String : Any] ?? [:]
            var RestaurantArray = dictionary["Restaurants"] as? [[String:Any]] ?? []
            if let rest = self.restaurant {
                // modify value "currentPeople"
                var currentPeople = RestaurantArray[rest.id]["currentPeople"] as? Int ?? -1
                
                if currentPeople < 0 { // failed
                    // failed to get data
                    print("failed to get data, abort transaction : runTransaction")
                    return TransactionResult.abort()
                } else if currentPeople > 1 { // failed
                    // more than 2 people -> party full
                    print("party full : runTransaction")
                    return TransactionResult.abort()
                } else if currentPeople == 0 { // succeed
                    // wait for another person
                    currentPeople += 1
                } else if currentPeople == 1 { // succeed
                    // party created!
                    currentPeople -= 1
                }
                
                // apply changes
                RestaurantArray[rest.id]["currentPeople"] = currentPeople
                dictionary["Restaurants"] = RestaurantArray
                currentData.value = dictionary
            }
            
            // finish transaction
            return TransactionResult.success(withValue: currentData)
        }) { (error, committed, snapshot) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func partyButton(_ sender: Any) {
        let alert = UIAlertController(title : "같이 먹을래", message : "20분 안에 올 수 있으시죠?", preferredStyle : UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title : "네", style: UIAlertActionStyle.default, handler: runTransaction)
        let cancelAction = UIAlertAction(title : "힘들 것 같아요", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        present(alert, animated: true , completion: nil)
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
