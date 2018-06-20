//
//  RestaurantTableViewController.swift
//  Honbabhanyang
//
//  Created by hojun on 10/05/2018.
//  Copyright © 2018 hojun. All rights reserved.
//

import UIKit
import FirebaseDatabase
import UserNotifications

class RestaurantTableViewController: UITableViewController {
    
    var byFood: Bool = false // filter by Food
    var byLocation: Bool = false // filter by Location
    var enumIndex: Int = 0 // Genre/Region enum index for filtering
    var rests: [Restaurant] = [] // filtered Restaurant objects : objects to be shown on the table
    @IBOutlet var restTableView: UITableView! // current tableView : for reloading the table
    
    // show notification
    func alertUser() {
        let alarmContent = UNMutableNotificationContent()
        alarmContent.title = "혼밥하냥"
        alarmContent.body = "매칭이 완료되었습니다! 지금 바로 확인!"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "timerdone", content: alarmContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    @objc func loadData() {
        let restData = RestaurantData()
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        // get realtime database
        ref.observe(.value, with: { snapshot in
            restData.restaurants = []
            
            let dictionary = snapshot.value as? [String: Any] ?? [:]
            let RestaurantArray = dictionary["Restaurants"] as? [[String:Any]] ?? []
            
            // get all restaurant data
            var index = 0
            for rest in RestaurantArray {
                // get each class member from JSON
                let id = index
                index += 1
                let name = rest["name"] as? String ?? ""
                guard let region = Region.enumFromString(string: rest["region"] as? String ?? "") else {
                    print("failed to get restaurant data : Region")
                    return }
                guard let genre = Genre.enumFromString(string: rest["genre"] as? String ?? "") else {
                    print("failed to get restaurant data : Genre")
                    return }
                let phoneNumber = rest["phoneNumber"] as? String ?? ""
                let currentPeople = rest["currentPeople"] as? Int ?? 0
                let party : Party = Party(menu: "Free To Choose", maxPeople: 2)
                party.currentPeople = currentPeople
                let wait1UID = rest["wait1UID"] as? String ?? ""
                let wait2UID = rest["wait2UID"] as? String ?? ""
                
                // if my waiting party is created
                if currentPeople == 0 && currentlyInParty == id{
                    self.alertUser()

                    // use wait1 and wait2 to create history entry////////////////////////////////
                    // create history data
                    let data = HistoryCenter(rest: Restaurant(id: id, name: name, region: region, genre: genre, phoneNumber: phoneNumber), user1ID: wait1UID, user2ID: wait2UID)
                    data.save()
                }
                
                // create new Restaurant class
                let res = Restaurant.init(id: id, name: name, region: region, genre: genre, phoneNumber: phoneNumber)
                res.parties = [party]
                
                // append restaurant to the array of restaurants
                restData.restaurants.append(res)
            }
            
            // filter data
            if self.byFood {
                self.rests = restData.restaurants.filter {
                    $0.genre == Genre(rawValue: self.enumIndex)
                }
            } else if self.byLocation{
                self.rests = restData.restaurants.filter {
                    $0.region == Region(rawValue: self.enumIndex)
                }
            } else {
                print("RestaurantTableViewController : byFood byLocation both false")
            }
            
            // reload data
            DispatchQueue.main.async {
                self.restTableView.reloadData()
            }
            
            // for refresh control
            if let refresh = self.refreshControl {
                refresh.endRefreshing()
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load data from Firebase realtime DB
        loadData()
        
        // Add Refresh Control to Table View
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:  #selector(loadData), for: UIControlEvents.valueChanged)
        self.refreshControl = refreshControl
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rests.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as! RestaurantTableViewCell

        // Configure the cell...
        //cell.textLabel?.text = rests[indexPath.row].name
        cell.restaurantName.text = rests[indexPath.row].name
        if let p = rests[indexPath.row].parties {
            cell.partyInfo.text = "\(p[0].currentPeople)/\(p[0].maxPeople)"
        } else {
            print("party not found?")
        }

        return cell
    }

    @IBAction func partyButton(_ sender: Any) {
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let vc = segue.destination as? RestaurantInfoViewController {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                vc.restaurant = rests[indexPath.row]
            }
        }
    }
}
