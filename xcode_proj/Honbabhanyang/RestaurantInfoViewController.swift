//
//  RestaurantInfoViewController.swift
//  Honbabhanyang
//
//  Created by hojun on 30/05/2018.
//  Copyright © 2018 hojun. All rights reserved.
//

import UIKit

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
