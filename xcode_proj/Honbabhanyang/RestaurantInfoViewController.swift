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
    @IBOutlet weak var currentPartyInfo: UILabel!
    @IBOutlet weak var partyJoinButton: UIButton!

    
    var restaurant: Restaurant?
    
    // setup information to the view
    func setupInfo() {
        // write texts on the View
        if let rest = restaurant {
            name.text = "\(rest.name)"
            region.text = "동네 : \(rest.region)"
            genre.text = "음식 종류 : \(rest.genre)"
            phoneNumber.text = "전화 번호 : \(rest.phoneNumber)"
            if let party = rest.parties {
                currentPartyInfo.text = "현재 파티 인원 : \(party[0].currentPeople)/\(party[0].maxPeople)"
            }
        }
        // button
        if currentlyInParty == 1 {
            partyJoinButton.setTitle("참여 취소", for: .normal)
            partyJoinButton.backgroundColor = UIColor(red: 209/255, green: 182/255, blue: 225/255, alpha: 1.0)
        } else {
            partyJoinButton.setTitle("파티에 참여", for: .normal)
            partyJoinButton.backgroundColor = UIColor(red: 157/255, green: 200/255, blue: 200/255, alpha: 1.0)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // try to join party
    func joinParty(action: UIAlertAction) {
        // get Firebase Realtime Database reference
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
                    
                    // show fail alert
                    let alert = UIAlertController(title : "Error", message : "데이터를 받아오는데 실패했어요.. 다시 시도해주세요 :D", preferredStyle : UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title : "확인", style: UIAlertActionStyle.default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true , completion: nil)
                    
                    // abort transaction
                    return TransactionResult.abort()
                } else if currentPeople > 1 { // failed
                    // more than 2 people -> party full
                    print("party full : runTransaction")
                    
                    // show fail alert
                    let alert = UIAlertController(title : "Error", message : "파티가 꽉 찼네요! 다시 시도해주세요 :D", preferredStyle : UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title : "확인", style: UIAlertActionStyle.default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true , completion: nil)
                    
                    // abort transaction
                    return TransactionResult.abort()
                } else if currentPeople == 0 { // succeed
                    // wait for another person
                    currentlyInParty = 1
                    currentPeople += 1
                    self.restaurant?.parties?[0].currentPeople = currentPeople
                    
                    // show success alert
                    let alert = UIAlertController(title : "참여 성공!", message : "다른 사람이 참여하면 불러드릴게요 :D", preferredStyle : UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title : "확인", style: UIAlertActionStyle.default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true , completion: nil)
                } else if currentPeople == 1 { // succeed
                    // party created!
                    currentlyInParty = 1
                    currentPeople -= 1
                    self.restaurant?.parties?[0].currentPeople = currentPeople
                    
                    // show success alert
                    let alert = UIAlertController(title : "참여 성공!", message : "매칭이 완료되었습니다! 20분 안에 오셔야해요!", preferredStyle : UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title : "확인", style: UIAlertActionStyle.default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true , completion: nil)
                }
                
                // apply changes
                RestaurantArray[rest.id]["currentPeople"] = currentPeople
                dictionary["Restaurants"] = RestaurantArray
                currentData.value = dictionary
            }
            
            // reload information
            DispatchQueue.main.async {
                self.setupInfo()
            }
            
            // finish transaction
            return TransactionResult.success(withValue: currentData)
        }) { (error, committed, snapshot) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func quitParty(action: UIAlertAction) {
        // get Firebase Realtime Database reference
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
                    
                    // show fail alert
                    let alert = UIAlertController(title : "Error", message : "데이터를 받아오는데 실패했어요.. 다시 시도해주세요 :D", preferredStyle : UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title : "확인", style: UIAlertActionStyle.default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true , completion: nil)
                    
                    // abort transaction
                    return TransactionResult.abort()
                    
                } else if currentPeople > 1 { // failed
                    // more than 2 people -> party full
                    print("party full : runTransaction")
                    
                    // show fail alert
                    let alert = UIAlertController(title : "Error", message : "다시 시도해주세요 :D", preferredStyle : UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title : "확인", style: UIAlertActionStyle.default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true , completion: nil)
                    
                    // abort transaction
                    return TransactionResult.abort()
                } else if currentPeople == 0 { // failed
                    // matching already done
                    
                    // show fail alert
                    let alert = UIAlertController(title : "취소 실패..", message : "이미 매칭이 완료됐어요..", preferredStyle : UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title : "확인", style: UIAlertActionStyle.default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true , completion: nil)
                    
                    // abort transaction
                    return TransactionResult.abort()
                    
                } else if currentPeople == 1 { // succeed
                    // party created!
                    currentlyInParty = 0
                    currentPeople -= 1
                    self.restaurant?.parties?[0].currentPeople = currentPeople
                    
                    // show success alert
                    let alert = UIAlertController(title : "", message : "취소 성공", preferredStyle : UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title : "확인", style: UIAlertActionStyle.default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true , completion: nil)
                }
                
                // apply changes
                RestaurantArray[rest.id]["currentPeople"] = currentPeople
                dictionary["Restaurants"] = RestaurantArray
                currentData.value = dictionary
            }
            
            // reload information
            DispatchQueue.main.async {
                self.setupInfo()
            }
            
            // finish transaction
            return TransactionResult.success(withValue: currentData)
        }) { (error, committed, snapshot) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
        // reload information
        DispatchQueue.main.async {
            self.setupInfo()
        }
    }
    
    @IBAction func partyButton(_ sender: Any) {
        // show alert for joining a party
        if currentlyInParty == 0 {
            let alert = UIAlertController(title : "같이 먹을래?", message : "20분 안에 올 수 있으시죠?", preferredStyle : UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title : "네", style: UIAlertActionStyle.default, handler: joinParty)
            let cancelAction = UIAlertAction(title : "힘들 것 같아요", style: UIAlertActionStyle.default, handler: nil)
            
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            
            present(alert, animated: true , completion: nil)
            
        } else {
            let alert = UIAlertController(title : "참여 취소", message : "정말 취소하실건가요?", preferredStyle : UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title : "네", style: UIAlertActionStyle.default, handler: quitParty)
            let cancelAction = UIAlertAction(title : "아니요", style: UIAlertActionStyle.default, handler: nil)
            
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            
            present(alert, animated: true , completion: nil)
        }
        
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
