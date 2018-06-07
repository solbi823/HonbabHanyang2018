//
//  RestaurantTableViewController.swift
//  Honbabhanyang
//
//  Created by hojun on 10/05/2018.
//  Copyright © 2018 hojun. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    var byFood: Bool = false
    var byLocation: Bool = false
    var enumIndex: Int = 0
    var rests: [Restaurant] = []
    var restData = RestaurantData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if byFood {
            rests = restData.restaurants.filter {
                $0.genre == Genre(rawValue: enumIndex)
            }
        } else if byLocation{
            rests = restData.restaurants.filter {
                $0.region == Region(rawValue: enumIndex)
            }
        } else {
            print("RestaurantTableViewController : byFood byLocation both false")
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
