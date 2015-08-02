//
//  SymptomTableViewController.swift
//  SymptomsGraph
//
//  Created by James on 8/1/15.
//  Copyright (c) 2015 James. All rights reserved.
//

import UIKit
import Alamofire

class SymptomTableViewController: UITableViewController {

    @IBOutlet weak var emojiMo1: UILabel!
    @IBOutlet weak var emojiMo2: UILabel!
    @IBOutlet weak var emojiMo3: UILabel!
    @IBOutlet weak var tempMo1: UILabel!
    @IBOutlet weak var tempMo2: UILabel!
    @IBOutlet weak var tempMo3: UILabel!
    @IBOutlet weak var emojiTu1: UILabel!
    @IBOutlet weak var emojiTu2: UILabel!
    @IBOutlet weak var emojiTu3: UILabel!
    @IBOutlet weak var tempTu1: UILabel!
    @IBOutlet weak var tempTu2: UILabel!
    @IBOutlet weak var tempTu3: UILabel!
    @IBOutlet weak var emojiWe1: UILabel!
    @IBOutlet weak var emojiWe2: UILabel!
    @IBOutlet weak var emojiWe3: UILabel!
    @IBOutlet weak var tempWe1: UILabel!
    @IBOutlet weak var tempWe2: UILabel!
    @IBOutlet weak var tempWe3: UILabel!
    @IBOutlet weak var emojiTh1: UILabel!
    @IBOutlet weak var emojiTh2: UILabel!
    @IBOutlet weak var emojiTh3: UILabel!
    @IBOutlet weak var tempTh1: UILabel!
    @IBOutlet weak var tempTh2: UILabel!
    @IBOutlet weak var tempTh3: UILabel!
    @IBOutlet weak var emojiFr1: UILabel!
    @IBOutlet weak var emojiFr2: UILabel!
    @IBOutlet weak var emojiFr3: UILabel!
    @IBOutlet weak var tempFr1: UILabel!
    @IBOutlet weak var tempFr2: UILabel!
    @IBOutlet weak var tempFr3: UILabel!
    @IBOutlet weak var emojiSa1: UILabel!
    @IBOutlet weak var emojiSa2: UILabel!
    @IBOutlet weak var emoji3Sa: UILabel!
    @IBOutlet weak var tempSa1: UILabel!
    @IBOutlet weak var tempSa2: UILabel!
    @IBOutlet weak var tempSa3: UILabel!
    @IBOutlet weak var emojiSu1: UILabel!
    @IBOutlet weak var emojiSu2: UILabel!
    @IBOutlet weak var emojiSu3: UILabel!
    @IBOutlet weak var tempSu1: UILabel!
    @IBOutlet weak var tempSu2: UILabel!
    @IBOutlet weak var tempSu3: UILabel!
    
    
    var feelings = ["Happy": "😀", "Achy": "😢", "Sick":"😷", "Tired":"😫", "Acute":"😭"]
    var mondayCount = 0
    var tuesdayCount = 0
    var wednesdayCount = 0
    var thursdayCount = 0
    var fridayCount = 0
    var saturdayCount = 0
    var sundayCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLocalData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    func getLocalData()
    {
        var path = NSBundle.mainBundle().pathForResource("graphsymptoms", ofType: "json")
        var localFileUrl = NSURL.fileURLWithPath(path!)!
        
        Alamofire.request(.GET, localFileUrl).responseJSON(options: NSJSONReadingOptions.MutableContainers)
            { (request, response, data, error) in
                
                println(request)
                println()
                println(response)
                println()
                println(data)
                println()
                println(error)
                println()
                
                if(error != nil)
                {
                    println(error!.localizedDescription)
                    // bail out
                    
                    return
                }
               
                let resultAsJSON = data as! NSArray
                if let SymptomDictionary = resultAsJSON[0] as? NSDictionary
                {
                    if let symArr = SymptomDictionary["Symptoms"] as? NSArray
                    {
                        println(symArr)
                        for data in symArr
                        {
                            switch data["Day"] as! String
                            {
                                case "Monday":
                            
                                if self.mondayCount == 0
                                {
                                    self.emojiMo1.text = self.feelings[(data["Feelings"] as? String)!]
                                    self.tempMo1.text = (data["Temp"]! as? Double)!.toString()
                                }
                                else if self.mondayCount == 1
                                {
                                    self.emojiMo2.text = self.feelings[(data["Feelings"] as? String)!]
                                    self.tempMo2.text = (data["Temp"]! as? Double)!.toString()
                                }
                                else if self.mondayCount == 2
                                {
                                    self.emojiMo3.text = self.feelings[(data["Feelings"] as? String)!]
                                    self.tempMo3.text = (data["Temp"]! as? Double)!.toString()
                                }
                                
                                self.mondayCount++
                                println(self.mondayCount)
                                
                                case "Tuesday":
                                
                                    if self.tuesdayCount == 0
                                    {
                                        self.emojiTu1.text = self.feelings[(data["Feelings"] as? String)!]
                                        self.tempTu1.text = (data["Temp"]! as? Double)!.toString()
                                    }
                                    else if self.tuesdayCount == 1
                                    {
                                        self.emojiTu2.text = self.feelings[(data["Feelings"] as? String)!]
                                        self.tempTu2.text = (data["Temp"]! as? Double)!.toString()
                                    }
                                    else if self.tuesdayCount == 2
                                    {
                                        self.emojiTu3.text = self.feelings[(data["Feelings"] as? String)!]
                                        self.tempTu3.text = (data["Temp"]! as? Double)!.toString()
                                    }
                                
                                self.tuesdayCount++
                                
                                case "Wednesday":
                                    
                                    if self.wednesdayCount == 0
                                    {
                                        self.emojiWe1.text = self.feelings[(data["Feelings"] as? String)!]
                                        self.tempWe1.text = (data["Temp"]! as? Double)!.toString()
                                    }
                                    else if self.wednesdayCount == 1
                                    {
                                        self.emojiWe2.text = self.feelings[(data["Feelings"] as? String)!]
                                        self.tempWe2.text = (data["Temp"]! as? Double)!.toString()
                                    }
                                    else if self.wednesdayCount == 2
                                    {
                                        self.emojiWe3.text = self.feelings[(data["Feelings"] as? String)!]
                                        self.tempWe3.text = (data["Temp"]! as? Double)!.toString()
                                    }
                                    
                                    self.wednesdayCount++
                                    println()
                                case "Thursday":
                                    
                                    if self.thursdayCount == 0
                                    {
                                        self.emojiTh1.text = self.feelings[(data["Feelings"] as? String)!]
                                        self.tempTh1.text = (data["Temp"]! as? Double)!.toString()
                                    }
                                    else if self.thursdayCount == 1
                                    {
                                        self.emojiTh2.text = self.feelings[(data["Feelings"] as? String)!]
                                        self.tempTh2.text = (data["Temp"]! as? Double)!.toString()
                                    }
                                    else if self.thursdayCount == 2
                                    {
                                        self.emojiTh3.text = self.feelings[(data["Feelings"] as? String)!]
                                        self.tempTh3.text = (data["Temp"]! as? Double)!.toString()
                                    }
                                    
                                    self.thursdayCount++
                                    println()
                                case "Friday":
                                    println()
                                case "Saturday":
                                    println()
                                case "Sunday":
                                    println()
                            default:
                                println()
                            }
                        }
                    }
                }
                
                
                return // don't try to get token info it failed so just exit
                
        } // End Alamofire.request
    }


  //  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

   // let cell = super.tableView.cellForRowAtIndexPath(indexPath)
    
    // Configure the cell...
    
  //  var section = indexPath.section
  //  var row = indexPath.row
    
   // if row == 1 // Monday
   // {
    
   // }
    
   // return cell!
    
  //  }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}


extension Double {
    func toString() -> String {
        return String(format: "%.2f",self)
    }
}
