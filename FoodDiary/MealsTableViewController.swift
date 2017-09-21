//
//  MealsTableViewController.swift
//  Food Diary
//
//  Created by Jeff Tobin on 12/6/16.
//  Copyright © 2016 Jeff Tobin. All rights reserved.
//

import UIKit

class MealsTableViewController: UITableViewController {
    
    var daysList = DailyMealsList()
    var mealsPerSection   = 3
    var dailySectionCount = 0
    
    //unwind segue from settings
    @IBAction func backToMeals(segue:UIStoryboardSegue) {
    }
    
    //adds new daily meals section
    @IBAction func addDailyMeals(_ sender: UIBarButtonItem) {
        //get date string
        let date                = NSDate()
        let dateFormatter       = DateFormatter()
        dateFormatter.dateStyle = .full
        var dateString          = dateFormatter.string(from: date as Date)
        let duplicateString     = dateString.appending(" (repeat date)")
        
        //check if date already exsists
        if dateString == daysList.daysList.first?.date ||
        duplicateString == daysList.daysList.first?.date {
            dateString = duplicateString
        }
        
        //create new day
        daysList.addNewDay(date: dateString)
        dailySectionCount += 1
        tableView.reloadData()
    }
    
    //view loaded
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // reload before view appears
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    //returns number of sections in table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dailySectionCount
    }

    //returns number of rows in table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealsPerSection
    }

    //displays cell titles
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dailyMealCell", for: indexPath)
        
        //diplays title based on row number
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Breakfast"
        case 1:
            cell.textLabel?.text = "Lunch"
        case 2:
            cell.textLabel?.text = "Dinner"
        case 3:
            cell.textLabel?.text = "Snack"
        default:
            cell.textLabel?.text = "4th Meal"
        }
        
        return cell
    }
    
    //displays section header
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = daysList.getDay(index: section).date
        return date
    }
    
    //sets section footer size for spacing
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    //assigns section footer a blank view for spacing
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view : UIView = tableSpacerView()
        return view
    }

    //prepare content for screen transition
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? MealViewController {
            //get selected row & section
            let section = tableView.indexPathForSelectedRow?.section
            let row     = tableView.indexPathForSelectedRow?.row
            
            //send meal type & title based on selected row
            switch row {
            case 0?:
                dest.meal = daysList.getDay(index: section!).breakfast
                dest.titleBar.title = "Breakfast"
                break
            case 1?:
                dest.meal = daysList.getDay(index: section!).lunch
                dest.titleBar.title = "Lunch"
                break
            case 2?:
                dest.meal = daysList.getDay(index: section!).dinner
                dest.titleBar.title = "Dinner"
                break
            case 3?:
                dest.meal = daysList.getDay(index: section!).snack
                dest.titleBar.title = "Snack"
                break
            default:
                print("error: no 5th meal per day")
            }
        }
    }
    
    //get documents directory path
    func getArchivePath() -> NSURL{
        let fileManager = FileManager()// NSFileManager.defaultManager()
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = urls.last
        let fileWithPath = documentDirectory?.appendingPathComponent("archive.data")
        return fileWithPath! as NSURL
    }
    
    //encode data into ducuments directory (save)
    func archiveData() {
        let archiveURL = getArchivePath()
        let storredList = NSKeyedArchiver.archiveRootObject(daysList, toFile: archiveURL.path!)
        if !storredList {
            print("Archiving failed")
        }
    }
    
    //dencode data from ducuments directory (load)
    func unarchiveData() {
        let archiveURL = getArchivePath()
        print("archiveURL: \(archiveURL)")
        let storedData = NSKeyedUnarchiver.unarchiveObject(withFile: archiveURL.path!)
        if let storedDaysList = storedData as? DailyMealsList {
            daysList          = storedDaysList
            dailySectionCount = daysList.daysList.count
            mealsPerSection   = daysList.numMeals
        }
        else {
            print("Unarchiving failed")
        }
    }

}
