//
//  PartyHistoryTableViewController.swift
//  Honbabhanyang
//
//  Created by hodo on 2018. 6. 6..
//  Copyright © 2018년 hojun. All rights reserved.
//

import UIKit

class PartyHistoryTableViewController: UITableViewController {
    
    let fileName = "History.brch"
    var filePath : String {
        get {
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            return documentDirectory + fileName
        }
    }
    var history:[saveParty] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if FileManager.default.fileExists(atPath: filePath) {
            if let unarchArray = NSKeyedUnarchiver.unarchiveObject(withFile:filePath) as? [saveParty] {
                history = unarchArray
            }
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
        return history.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        let selectedItem = history[indexPath.row]
        //cell.textLabel!.text = selectedItem.party!.menu
        cell.textLabel!.text = selectedItem.restName
        cell.detailTextLabel!.text = selectedItem.date
        // Configure the cell...
        
        return cell
    }
    
    
     override func  prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if let indexPath = self.tableView.indexPathForSelectedRow,
     let vc = segue.destination as? HistoryDetailViewController {
        //vc.partyDetail = history[indexPath.row].party
        //vc.partyDetail = history[indexPath.row].party
        let selected = history[indexPath.row]
        vc.vcpartyDate = selected.date
        vc.vcpartyID = selected.partyID
        vc.vcpartyMaxPeople = selected.maxPeople
        vc.vcpartyMenu = selected.menu
        vc.vcrestName = selected.restName
        vc.vcrestPhone = selected.restPhone
        vc.vcrestGenre = selected.restGenre
        vc.vcrestRegion = selected.restRegion
        }
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

