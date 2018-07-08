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
    

    @IBOutlet weak var diamondNameLabel: UILabel!
    
    @IBOutlet weak var diamondIDLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var diamondPriceLabel: UILabel!
    
    @IBOutlet weak var supplierIDLabel: UILabel!
    
    var supplierIDString: String!
    var diamondIDString: String!
    var diamondPrice: String!
    var diamondName: String!
    var nameOfUser: String!
    
    var receiptData: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        diamondNameLabel.text = diamondName
        nameLabel.text = nameOfUser
        diamondPriceLabel.text = "$" + diamondPrice
        diamondIDLabel.text = diamondIDString
        supplierIDLabel.text = supplierIDString
        
        //print("Receipt data:", receiptData)
        
        /*
        diamondNameLabel.text = receiptData.diamondName
        nameLabel.text = receiptData.name
        supplierNameLabel.text = receiptData.supplierName
        supplierLocationLabel.text = receiptData.supplierLocation
        */
        //print("The Receipt Data:", receiptData.diamondName)
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
