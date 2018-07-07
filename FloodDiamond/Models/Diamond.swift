//
//  Diamond.swift
//  FloodDiamond
//
//  Created by Fabrice Mulumba on 7/7/18.
//  Copyright © 2018 Fabrice Mulumba. All rights reserved.
//
//  Model for diamonds
// Using Swift 4 now, should use Codables and Decodables

import Foundation


struct Diamond: Decodable {
    
    let _id: String
    let name: String
    let carat: Double
    let supplierId: String
    let description: String
    let image: String
    let price: Int
}

/*
class Diamond {
    
    private var _id: String! //id
    
    private var _name: String! //name of the diamond.
    
    private var _carat: String! //carat of the diamond
    
    private var _diamondID: String! //ID of the diamond.
    
    private var _description: String! //Description of the diamond.
    
   private var _price: String! //Price of the diamond.
    
    
    var id: String { //Returns the value of _id when called.
        return _id
    }
    
    var name: String { //Returns the value of _name when called.
        return _name
    }
    
    var carat: String { //Returns the value of _carat when called.
        return _carat
    }
    
    var diamondID: String { //Returns the value of _diamondID when called.
        return _diamondID
    }
    
    
    var description: String { //Returns the value of _description when called.
        return _description
    }
 
 }
 */
    

