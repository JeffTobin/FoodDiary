//
//  Meal.swift
//  Food Diary
//
//  Created by Jeff Tobin on 12/8/16.
//  Copyright © 2016 Jeff Tobin. All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding {
    var mealDescription : String  = ""
    var mealImage       : UIImage = #imageLiteral(resourceName: "placeholder")
    
    override init() {
        super.init()
    }
    
    init(mealDescription : String, mealImage : UIImage) {
        self.mealDescription = mealDescription
        self.mealImage       = mealImage
        super.init()
    }
    
    //Encode & save properties
    func encode(with aCoder: NSCoder) {
        aCoder.encode(mealDescription, forKey: "mealDescription")
        aCoder.encode(mealImage,       forKey: "mealImage")
    }
    
    //Decode & restore properties
    required init?(coder aDecoder: NSCoder) {
        mealDescription = (aDecoder.decodeObject(forKey: "mealDescription") as? String)!
        mealImage       = (aDecoder.decodeObject(forKey: "mealImage")       as? UIImage)!
    }
}
