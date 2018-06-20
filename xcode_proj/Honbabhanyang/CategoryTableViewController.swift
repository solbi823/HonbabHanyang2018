//
//  CategoryTableViewController.swift
//  Honbabhanyang
//
//  Created by hojun on 30/05/2018.
//  Copyright © 2018 hojun. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    var byFood: Bool = false
    var byLocation: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // remove empty table entries
        self.tableView.tableFooterView = UIView(frame: .zero)
        
        // show title name 
        if byFood {
            self.title = "음식으로 찾기"
        } else {
            self.title = "동네로 찾기"
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
        if byFood {
            return Genre.count
        } else if byLocation {
            return Region.count
        } else {
            print("CategoryTableViewController : should not come here!")
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        

        // Configure the cell...
        if byFood {
            if let enumValue = Genre(rawValue: indexPath.row) {
                cell.textLabel?.text = "\(enumValue)"
                cell.textLabel?.font = UIFont(name:"NanumBarunpen", size:20)
            }
        } else if byLocation {
            if let enumValue = Region(rawValue: indexPath.row) {
                cell.textLabel?.text = "\(enumValue)"
                cell.textLabel?.font = UIFont(name:"NanumBarunpen", size:20)
            }
        } else {
            print("CategoryTableViewController : should not come here!")
        }

        return cell
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
        if let vc = segue.destination as? RestaurantTableViewController {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                vc.enumIndex = indexPath.row
            }
            vc.byFood = byFood
            vc.byLocation = byLocation
        }
    }
}
