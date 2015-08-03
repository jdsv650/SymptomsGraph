//
//  SymptomTableViewController.swift
//  SymptomsGraph
//
//  Created by James on 8/1/15.
//  Copyright (c) 2015 James. All rights reserved.
//

import UIKit
import Alamofire  // for network/local (JSON) request

class SymptomTableViewController: UITableViewController {

    @IBOutlet weak var emojiMo1: UILabel!  // emoji Monday 1
    @IBOutlet weak var emojiMo2: UILabel!  // emoji Monday 2
    @IBOutlet weak var emojiMo3: UILabel!  // emoji Monday 3
    @IBOutlet weak var tempMo1: UILabel!   // Temperature Monday 1
    @IBOutlet weak var tempMo2: UILabel!   // Temperature Monday 2
    @IBOutlet weak var tempMo3: UILabel!   // Temperature Monday 3
    @IBOutlet weak var emojiTu1: UILabel!  // ...
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
    var mondayCount = 0      // track number of times Monday is found in json
    var tuesdayCount = 0     // ...                   Tuesday ...
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
    
    func getLocalData()
    {
        var path = NSBundle.mainBundle().pathForResource("graphsymptoms2", ofType: "json")
        var localFileUrl: NSURL
        
        // See if we can find the local json file
        if let thepath = path
        {
            localFileUrl = NSURL.fileURLWithPath(thepath)!
        }
        else
        {
            showPopup("Error", message: "Unable to read data")
            return
        }
        
        // go ahead and read the json file using Alamofire
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
                    // bail out - call failed
                    println(error!.localizedDescription)
                    self.showPopup("Error", message: error!.localizedDescription)
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
                            // feelings emoji is empty "" unless we find "Feelings" with a matching type
                            var feelings = ""
                            if let feel = data["Feelings"] as? String
                            {
                                if let feelAsEmoji = self.feelings[feel]
                                {
                                    feelings = feelAsEmoji
                                }
                            }
                            
                            // temperature feild is empty "" unless we find "Temp" with a Double value
                            var temperature = ""
                            if let temp = data["Temp"] as? Double
                            {
                               temperature = temp.toString()
                            }
                            
                            // get the day of week and set labels for that day - up to 3 readings per day
                            switch data["Day"] as! String
                            {
                                case "Monday":
                            
                                if self.mondayCount == 0
                                {
                                    self.setTextForLabels(self.emojiMo1, temperatureLabel: self.tempMo1, emoji: feelings, temperature: temperature)
                                }
                                else if self.mondayCount == 1
                                {
                                    self.setTextForLabels(self.emojiMo2, temperatureLabel: self.tempMo2, emoji: feelings, temperature: temperature)
                                }
                                else if self.mondayCount == 2
                                {
                                    self.setTextForLabels(self.emojiMo3, temperatureLabel: self.tempMo3, emoji: feelings, temperature: temperature)
                                }
                    
                                self.mondayCount++
                                
                                case "Tuesday":
                                
                                    if self.tuesdayCount == 0
                                    {
                                        self.setTextForLabels(self.emojiTu1, temperatureLabel: self.tempTu1, emoji: feelings, temperature: temperature)
                                    }
                                    else if self.tuesdayCount == 1
                                    {
                                        self.setTextForLabels(self.emojiTu2, temperatureLabel: self.tempTu2, emoji: feelings, temperature: temperature)
                                    }
                                    else if self.tuesdayCount == 2
                                    {
                                        self.setTextForLabels(self.emojiTu3, temperatureLabel: self.tempTu3, emoji: feelings, temperature: temperature)
                                    }
                                
                                self.tuesdayCount++
                                
                                case "Wednesday":
                                    
                                    if self.wednesdayCount == 0
                                    {
                                        self.setTextForLabels(self.emojiWe1, temperatureLabel: self.tempWe1, emoji: feelings, temperature: temperature)
                                    }
                                    else if self.wednesdayCount == 1
                                    {
                                        self.setTextForLabels(self.emojiWe2, temperatureLabel: self.tempWe2, emoji: feelings, temperature: temperature)
                                    }
                                    else if self.wednesdayCount == 2
                                    {
                                        self.setTextForLabels(self.emojiWe3, temperatureLabel: self.tempWe3, emoji: feelings, temperature: temperature)
                                    }
                                    
                                    self.wednesdayCount++
                               
                                case "Thursday":
                                    
                                    if self.thursdayCount == 0
                                    {
                                        self.setTextForLabels(self.emojiTh1, temperatureLabel: self.tempTh1, emoji: feelings, temperature: temperature)
                                    }
                                    else if self.thursdayCount == 1
                                    {
                                        self.setTextForLabels(self.emojiTh2, temperatureLabel: self.tempTh2, emoji: feelings, temperature: temperature)
                                    }
                                    else if self.thursdayCount == 2
                                    {
                                        self.setTextForLabels(self.emojiTh3, temperatureLabel: self.tempTh3, emoji: feelings, temperature: temperature)
                                    }
                                    
                                    self.thursdayCount++
                               
                                case "Friday":
                                
                                    if self.fridayCount == 0
                                    {
                                        self.setTextForLabels(self.emojiFr1, temperatureLabel: self.tempFr1, emoji: feelings, temperature: temperature)
                                    }
                                    else if self.fridayCount == 1
                                    {
                                        self.setTextForLabels(self.emojiFr2, temperatureLabel: self.tempFr2, emoji: feelings, temperature: temperature)
                                    }
                                    else if self.fridayCount == 2
                                    {
                                        self.setTextForLabels(self.emojiFr3, temperatureLabel: self.tempFr3, emoji: feelings, temperature: temperature)
                                    }
                                    
                                    self.fridayCount++
                                
                                case "Saturday":
                                    
                                    if self.saturdayCount == 0
                                    {
                                        self.setTextForLabels(self.emojiSa1, temperatureLabel: self.tempSa1, emoji: feelings, temperature: temperature)
                                    }
                                    else if self.saturdayCount == 1
                                    {
                                        self.setTextForLabels(self.emojiSa2, temperatureLabel: self.tempSa2, emoji: feelings, temperature: temperature)
                                    }
                                    else if self.saturdayCount == 2
                                    {
                                        self.setTextForLabels(self.emojiSa3, temperatureLabel: self.tempSa3, emoji: feelings, temperature: temperature)
                                    }
                                    
                                    self.saturdayCount++
                                
                                case "Sunday":
                                
                                    if self.sundayCount == 0
                                    {
                                        self.setTextForLabels(self.emojiSu1, temperatureLabel: self.tempSu1, emoji: feelings, temperature: temperature)
                                    }
                                    else if self.sundayCount == 1
                                    {
                                        self.setTextForLabels(self.emojiSu2, temperatureLabel: self.tempSu2, emoji: feelings, temperature: temperature)
                                    }
                                    else if self.sundayCount == 2
                                    {
                                        self.setTextForLabels(self.emojiSu3, temperatureLabel: self.tempSu3, emoji: feelings, temperature: temperature)
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
    
    func setTextForLabels(emojiLabel: UILabel, temperatureLabel: UILabel, emoji: String, temperature: String)
    {
        emojiLabel.text = emoji
        temperatureLabel.text = temperature + " \u{00B0}F"
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

    // show an alert with key showing emoji / meaning
    @IBAction func infoPressed(sender: UIBarButtonItem)
    {
        showPopup("", message: " 😀 Happy 😀\n\n😧 Achy 😧\n\n😷 Sick 😷\n\n😫 Tired 😫\n\n😡 Acute 😡")
    }
    
    // display an alert controller with passed in title and message
    func showPopup(theTitle: String, message: String)
    {
        var alert = UIAlertController(title: theTitle, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        var action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}

// enable calling toString on a double
extension Double {
    func toString() -> String {
        return String(format: "%.2f",self)
    }
}
