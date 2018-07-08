//
//  DiamondCell.swift
//  FloodDiamond
//
//  Created by Fabrice Mulumba on 7/7/18.
//  Copyright © 2018 Fabrice Mulumba. All rights reserved.
//
// Cell for a diamond tableview cell
// Got weird error for image in Swift 4
//https://stackoverflow.com/questions/46362641/xcode-uiview-initwithframe-must-be-used-from-main-thread-only

import UIKit

class DiamondCell: UITableViewCell {

    @IBOutlet weak var diamondName: UILabel!
    
    @IBOutlet weak var diamondCarat: UILabel!
    
    @IBOutlet weak var diamondDescription: UILabel!
    
    @IBOutlet weak var buyDiamondButton: UIButton!
    
    @IBOutlet weak var diamondPriceLabel: UILabel!
    
    
    @IBOutlet weak var diamondImage: UIImageView!
    
    var diamond: Diamond!
    
    //Send ID of the diamond and the supplier
    @IBAction func buyButtonTapped(_ sender: Any) {
        print(diamond._id)
        print(diamond.supplierId)

    }
    
    func downloadImage(urlString: String, imageView: UIImageView) {
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async { // Make sure you're on the main thread here
                imageView.image = UIImage(data: data)
            }
        }
        task.resume()
    }
    
    func configureCell(diamond: Diamond) {
        self.diamond = diamond
        self.diamondName.text = diamond.name
        self.diamondCarat.text = String(diamond.carat) + " carats"//Convert to string
        self.diamondDescription.text = diamond.description
        self.diamondPriceLabel.text = "$" + String(diamond.price)
        downloadImage(urlString: diamond.image, imageView: self.diamondImage)

        buyDiamondButton.layer.cornerRadius = 10
        
    }
    
}
