//
//  SettingsViewController.swift
//  Food Diary
//
//  Created by Jeff Tobin on 12/7/16.
//  Copyright © 2016 Jeff Tobin. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    //declerations
    @IBOutlet weak var snackSwitchRef: UISwitch!
    var rootVC       : UINavigationController?
    var MealsTableVC : MealsTableViewController?

    override func viewDidLoad() {
        rootVC = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController?
        MealsTableVC = rootVC?.viewControllers[0] as! MealsTableViewController?
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //load snack switch's initial value
        if let mealsList = MealsTableVC {
            if(mealsList.mealsPerSection == 4) {
                snackSwitchRef.isOn = true
            }
            else {
                snackSwitchRef.isOn = false
            }
        }
    }

    //switch changes number of rows in MealsTableVC to: 4 if true / 3 if false
    @IBAction func snackSwitch(_ sender: UISwitch) {
        if let mealsList = MealsTableVC {
            if(snackSwitchRef.isOn == true) {
                mealsList.mealsPerSection   = 4
                mealsList.daysList.numMeals = 4
            }
            else{
                mealsList.mealsPerSection   = 3
                mealsList.daysList.numMeals = 3
            }
        }
    }
    
    //erases all meals data from dailyList stored in MealsTableVC
    @IBAction func eraseMealsButton(_ sender: UIButton) {
        if let mealsList = MealsTableVC {
            mealsList.dailySectionCount = 0
            mealsList.daysList.eraseDays()
        }
    }
}
