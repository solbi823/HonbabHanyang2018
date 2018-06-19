//
//  MainMenuViewController.swift
//  Honbabhanyang
//
//  Created by hojun on 30/05/2018.
//  Copyright © 2018 hojun. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    
    var byFood: Bool = false
    var byLocation: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // setup data
    }
    @IBAction func touchedFood(_ sender: Any) {
        byFood = true
        byLocation = false
    }
    @IBAction func touchedLocation(_ sender: Any) {
        byFood = false
        byLocation = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CategoryTableViewController {
            vc.byFood = byFood
            vc.byLocation = byLocation
        }
    }
 
    

}
