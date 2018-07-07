//
//  DiamondCell.swift
//  FloodDiamond
//
//  Created by Fabrice Mulumba on 7/7/18.
//  Copyright © 2018 Fabrice Mulumba. All rights reserved.
//
// Cell for a diamond tableview cell

import UIKit

class DiamondCell: UITableViewCell {

    @IBOutlet weak var diamondName: UILabel!
    
    @IBOutlet weak var diamondCarat: UILabel!
    
    @IBOutlet weak var diamondDescription: UILabel!
    
    @IBOutlet weak var buyButton: UIButton!
    
    var diamond: Diamond!
    

    //Send ID of the diamond and the supplier
    @IBAction func buyButtonTapped(_ sender: Any) {
        print(diamond._id)
        print(diamond.supplierId)

    }
    
    func configureCell(diamond: Diamond) {
        self.diamond = diamond
        self.diamondName.text = diamond.name
        self.diamondCarat.text = String(diamond.carat) //Convert to string
        self.diamondDescription.text = diamond.description
    }
    
    
    
    
}
