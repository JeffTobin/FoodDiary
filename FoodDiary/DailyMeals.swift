//
//  DailyMeals.swift
//  Food Diary
//
//  Created by Jeff Tobin on 12/8/16.
//  Copyright © 2016 Jeff Tobin. All rights reserved.
//

import UIKit

class DailyMeals: NSObject, NSCoding {
    var date : String = ""
    var breakfast = Meal()
    var lunch     = Meal()
    var dinner    = Meal()
    var snack     = Meal()
    
    override init() {
        super.init()
    }
    
    init(date : String) {
        self.date = date
        super.init()
    }
    
    //Encode & save properties
    func encode(with aCoder: NSCoder) {
        aCoder.encode(date,      forKey: "date")
        aCoder.encode(breakfast, forKey: "breakfast")
        aCoder.encode(lunch,     forKey: "lunch")
        aCoder.encode(dinner,    forKey: "dinner")
        aCoder.encode(snack,     forKey: "snack")
    }
    
    //Decode & restore properties
    required init?(coder aDecoder: NSCoder) {
        date      = (aDecoder.decodeObject(forKey: "date")      as? String)!
        breakfast = (aDecoder.decodeObject(forKey: "breakfast") as? Meal)!
        lunch     = (aDecoder.decodeObject(forKey: "lunch")     as? Meal)!
        dinner    = (aDecoder.decodeObject(forKey: "dinner")    as? Meal)!
        snack     = (aDecoder.decodeObject(forKey: "snack")     as? Meal)!
    }

}

