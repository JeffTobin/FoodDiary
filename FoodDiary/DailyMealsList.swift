//
//  DailyMealsList.swift
//  FoodDiary
//
//  Created by Jeff Tobin on 12/8/16.
//  Copyright © 2016 Jeff Tobin. All rights reserved.
//

import UIKit

class DailyMealsList: NSObject, NSCoding {
    var daysList = [DailyMeals]()
    var numMeals = 3
    
    override init() {
        super.init()
    }
    
    //add new days worth of meals
    func addNewDay(date : String) {
        let newDay = DailyMeals(date: date)
        daysList.insert(newDay, at:0)
    }
    
    //get a days set of meals from array
    func getDay(index : Int) -> DailyMeals {
        return daysList[index]
    }
    
    //erase all days from array
    func eraseDays() {
        daysList.removeAll()
    }
    
    //Encode & save properties
    func encode(with aCoder: NSCoder) {
        aCoder.encode(numMeals, forKey: "numMeals")
        aCoder.encode(daysList, forKey: "daysList")
    }
    
    //Decode & restore properties
    required init?(coder aDecoder: NSCoder) {
        numMeals = aDecoder.decodeInteger(forKey: "numMeals")
        daysList = (aDecoder.decodeObject(forKey: "daysList") as? [DailyMeals])!
    }
}
