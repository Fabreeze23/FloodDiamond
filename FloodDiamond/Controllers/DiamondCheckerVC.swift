//
//  FirstViewController.swift
//  FloodDiamond
//
//  Created by Fabrice Mulumba on 7/7/18.
//  Copyright © 2018 Fabrice Mulumba. All rights reserved.
//
//  Determine if a diamond is clean or not and sends it

import UIKit

class DiamondCheckerVC: UIViewController {
    
    @IBOutlet weak var diamondName: UILabel!
    
    @IBOutlet weak var diamondDescription: UILabel!
    
    @IBOutlet weak var diamondCarat: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        diamondName.text = DIAMOND_DATA["name"]
        diamondDescription.text = DIAMOND_DATA["description"]
        diamondCarat.text = DIAMOND_DATA["carat"]
        
    }


}

