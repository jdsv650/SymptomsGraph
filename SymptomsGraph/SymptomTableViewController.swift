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
    @IBOutlet weak var emojiSa3: UILabel!
    @IBOutlet weak var tempSa1: UILabel!
    @IBOutlet weak var tempSa2: UILabel!
    @IBOutlet weak var tempSa3: UILabel!
    @IBOutlet weak var emojiSu1: UILabel!
    @IBOutlet weak var emojiSu2: UILabel!
    @IBOutlet weak var emojiSu3: UILabel!
    @IBOutlet weak var tempSu1: UILabel!
    @IBOutlet weak var tempSu2: UILabel!
    @IBOutlet weak var tempSu3: UILabel!
    
    var feelings = ["Happy": "😀", "Achy": "😧", "Sick":"😷", "Tired":"😫", "Acute":"😡"]
    var mondayCount = 0
    var tuesdayCount = 0
    var wednesdayCount = 0
    var thursdayCount = 0
    var fridayCount = 0
    var saturdayCount = 0
    var sundayCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearLabels()
        getLocalData()
        
    }
    
    
    @IBAction func infoPressed(sender: UIBarButtonItem)
    {
        var message = " 😀 Happy 😀\n\n😧 Achy 😧\n\n😷 Sick 😷\n\n😫 Tired 😫\n\n😡 Acute 😡"
        var alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        var action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    func clearLabels()
    {
        emojiMo1.text = ""
        emojiMo2.text = ""
        emojiMo3.text = ""
        tempMo1.text = ""
        tempMo2.text = ""
        tempMo3.text = ""
        emojiTu1.text = ""
        emojiTu2.text = ""
        emojiTu3.text = ""
        tempTu1.text = ""
        tempTu2.text = ""
        tempTu3.text = ""
        emojiWe1.text = ""
        emojiWe2.text = ""
        emojiWe3.text = ""
        tempWe1.text = ""
        tempWe2.text = ""
        tempWe3.text = ""
        emojiTh1.text = ""
        emojiTh2.text = ""
        emojiTh3.text = ""
        tempTh1.text = ""
        tempTh2.text = ""
        tempTh3.text = ""
        emojiFr1.text = ""
        emojiFr2.text = ""
        emojiFr3.text = ""
        tempFr1.text = ""
        tempFr2.text = ""
        tempFr3.text = ""
        emojiSa1.text = ""
        emojiSa2.text = ""
        emojiSa3.text = ""
        tempSa1.text = ""
        tempSa2.text = ""
        tempSa3.text = ""
        emojiSu1.text = ""
        emojiSu2.text = ""
        emojiSu3.text = ""
        tempSu1.text = ""
        tempSu2.text = ""
        tempSu3.text = ""
    }
    
    func getLocalData()
    {
        var path = NSBundle.mainBundle().pathForResource("graphsymptoms2", ofType: "json")
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
                                    self.tempMo1.text = (data["Temp"]! as? Double)!.toString() + " \u{00B0}F"
                                }
                                else if self.mondayCount == 1
                                {
                                    self.emojiMo2.text = self.feelings[(data["Feelings"] as? String)!]
                                    self.tempMo2.text = (data["Temp"]! as? Double)!.toString() + " \u{00B0}F"
                                }
                                else if self.mondayCount == 2
                                {
                                    self.emojiMo3.text = self.feelings[(data["Feelings"] as? String)!]
                                    self.tempMo3.text = (data["Temp"]! as? Double)!.toString() + " \u{00B0}F"
                                }
                                
                                self.mondayCount++
                                
                                case "Tuesday":
                                
                                    if self.tuesdayCount == 0
                                    {
                                        self.emojiTu1.text = self.feelings[(data["Feelings"] as? String)!]
                                        self.tempTu1.text = (data["Temp"]! as? Double)!.toString() + " \u{00B0}F"
                                    }
                                    else if self.tuesdayCount == 1
                                    {
                                        self.emojiTu2.text = self.feelings[(data["Feelings"] as? String)!]
                                        self.tempTu2.text = (data["Temp"]! as? Double)!.toString() + " \u{00B0}F"
                                    }
                                    else if self.tuesdayCount == 2
                                    {
                                        self.emojiTu3.text = self.feelings[(data["Feelings"] as? String)!]
                                        self.tempTu3.text = (data["Temp"]! as? Double)!.toString() + " \u{00B0}F"
                                    }
                                
                                self.tuesdayCount++
                                
                                case "Wednesday":
                                    
                                    if self.wednesdayCount == 0
                                    {
                                        self.emojiWe1.text = self.feelings[(data["Feelings"] as? String)!]
                                        self.tempWe1.text = (data["Temp"]! as? Double)!.toString() + " \u{00B0}F"
                                    }
                                    else if self.wednesdayCount == 1
                                    {
                                        self.emojiWe2.text = self.feelings[(data["Feelings"] as? String)!]
                                        self.tempWe2.text = (data["Temp"]! as? Double)!.toString() + " \u{00B0}F"
                                    }
                                    else if self.wednesdayCount == 2
                                    {
                                        self.emojiWe3.text = self.feelings[(data["Feelings"] as? String)!]
                                        self.tempWe3.text = (data["Temp"]! as? Double)!.toString() + " \u{00B0}F"
                                    }
                                    
                                    self.wednesdayCount++
                               
                                case "Thursday":
                                    
                                    if self.thursdayCount == 0
                                    {
                                        self.emojiTh1.text = self.feelings[(data["Feelings"] as? String)!]
                                        self.tempTh1.text = (data["Temp"]! as? Double)!.toString() + " \u{00B0}F"
                                    }
                                    else if self.thursdayCount == 1
                                    {
                                        self.emojiTh2.text = self.feelings[(data["Feelings"] as? String)!]
                                        self.tempTh2.text = (data["Temp"]! as? Double)!.toString() + " \u{00B0}F"
                                    }
                                    else if self.thursdayCount == 2
                                    {
                                        self.emojiTh3.text = self.feelings[(data["Feelings"] as? String)!]
                                        self.tempTh3.text = (data["Temp"]! as? Double)!.toString() + " \u{00B0}F"
                                    }
                                    
                                    self.thursdayCount++
                               
                                case "Friday":
                                
                                    if self.fridayCount == 0
                                    {
                                        self.emojiFr1.text = self.feelings[(data["Feelings"] as? String)!]
                                        self.tempFr1.text = (data["Temp"]! as? Double)!.toString() + " \u{00B0}F"
                                    }
                                    else if self.fridayCount == 1
                                    {
                                        self.emojiFr2.text = self.feelings[(data["Feelings"] as? String)!]
                                        self.tempFr2.text = (data["Temp"]! as? Double)!.toString() + " \u{00B0}F"
                                    }
                                    else if self.fridayCount == 2
                                    {
                                        self.emojiFr3.text = self.feelings[(data["Feelings"] as? String)!]
                                        self.tempFr3.text = (data["Temp"]! as? Double)!.toString() + " \u{00B0}F"
                                    }
                                    
                                    self.fridayCount++
                                
                                case "Saturday":
                                    
                                    if self.saturdayCount == 0
                                    {
                                        self.emojiSa1.text = self.feelings[(data["Feelings"] as? String)!]
                                        self.tempSa1.text = (data["Temp"]! as? Double)!.toString() + " \u{00B0}F"
                                    }
                                    else if self.saturdayCount == 1
                                    {
                                        self.emojiSa2.text = self.feelings[(data["Feelings"] as? String)!]
                                        self.tempSa2.text = (data["Temp"]! as? Double)!.toString() + " \u{00B0}F"
                                    }
                                    else if self.saturdayCount == 2
                                    {
                                        self.emojiSa3.text = self.feelings[(data["Feelings"] as? String)!]
                                        self.tempSa3.text = (data["Temp"]! as? Double)!.toString() + " \u{00B0}F"
                                    }
                                    
                                    self.saturdayCount++
                                
                                case "Sunday":
                                
                                    if self.sundayCount == 0
                                    {
                                        self.emojiSu1.text = self.feelings[(data["Feelings"] as? String)!]
                                        self.tempSu1.text = (data["Temp"]! as? Double)!.toString() + " \u{00B0}F"
                                    }
                                    else if self.sundayCount == 1
                                    {
                                        self.emojiSu2.text = self.feelings[(data["Feelings"] as? String)!]
                                        self.tempSu2.text = (data["Temp"]! as? Double)!.toString() + " \u{00B0}F"
                                    }
                                    else if self.sundayCount == 2
                                    {
                                        self.emojiSu3.text = self.feelings[(data["Feelings"] as? String)!]
                                        self.tempSu3.text = (data["Temp"]! as? Double)!.toString() + " \u{00B0}F"
                                    }
                                    
                                    self.sundayCount++
                                
                            default:
                                println()
                            }
                        }
                    }
                }
                
                return
                
        } // End Alamofire.request
    }

}


extension Double {
    func toString() -> String {
        return String(format: "%.2f",self)
    }
}
