//
//  ReceiptVC.swift
//  FloodDiamond
//
//  Created by Fabrice Mulumba on 7/7/18.
//  Copyright © 2018 Fabrice Mulumba. All rights reserved.
//
// Receipt for buying diamond. Segue from DiamondCell.swift and receives supplier and Diamond ID from there

import UIKit

class ReceiptVC: UIViewController {
    

    @IBOutlet weak var supplierIDLabel: UILabel!
    
    
    @IBOutlet weak var diamondIDLabel: UILabel!
    
    var supplierIDString: String!
    var diamondIDString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        supplierIDLabel.text = supplierIDString
        diamondIDLabel.text = diamondIDString
        print(supplierIDString)
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
