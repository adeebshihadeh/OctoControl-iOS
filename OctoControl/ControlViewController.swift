//
//  FirstViewController.swift
//  OctoControl
//
//  Created by quillford on 2/6/15.
//  Copyright (c) 2015 quillford. All rights reserved.
//

import UIKit

class ControlViewController: UIViewController {

    @IBOutlet weak var increment: UISegmentedControl!
    @IBOutlet weak var extruderOneSlider: UISlider!
    @IBOutlet weak var bedSlider: UISlider!
    @IBOutlet weak var extruderOneLabel: UILabel!
    @IBOutlet weak var bedLabel: UILabel!
    @IBOutlet weak var filamentLength: UITextField!
    
    @IBOutlet weak var extruderOneTempLabel: UILabel!
    @IBOutlet weak var bedTempLabel: UILabel!
    
    var ip = userDefaults.stringForKey("ip")
    var apikey = userDefaults.stringForKey("apikey")
    var jogIncrement: Float = 0.1
    var extruderOneTemp = 0
    var bedTemp = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            switch(increment.selectedSegmentIndex){
                case 0:
                    jogIncrement = 0.1;
                    break;
                case 1:
                    jogIncrement = 1;
                    break;
                case 2:
                    jogIncrement = 10;
                    break;
                case 3:
                    jogIncrement = 100;
                    break;
                default:
                    break;
            }
        extruderOneTempLabel.text = "Extruder 1: " + OctoPrint.getTemp()
        
        ip = userDefaults.stringForKey("ip")
        apikey = userDefaults.stringForKey("apikey")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func homeXY(sender: AnyObject) {
        OctoPrint.sendGcode("G28 XY", ip: ip!, apikey: apikey!)
    }
    
    @IBAction func homeZ(sender: AnyObject) {
        OctoPrint.sendGcode("G28 Z", ip: ip!, apikey: apikey!)
    }
    
    @IBAction func jogXLeft(sender: AnyObject) {
        OctoPrint.jog(ip!, apikey: apikey!, axis: "x", amount: -jogIncrement)
    }
    
    @IBAction func jogXRight(sender: AnyObject) {
        OctoPrint.jog(ip!, apikey: apikey!, axis: "x", amount: jogIncrement)
    }
    
    @IBAction func jogYUp(sender: AnyObject) {
        OctoPrint.jog(ip!, apikey: apikey!, axis: "y", amount: -jogIncrement)
    }
    
    @IBAction func jogYDown(sender: AnyObject) {
        OctoPrint.jog(ip!, apikey: apikey!, axis: "y", amount: jogIncrement)
    }
    
    @IBAction func jogZUp(sender: AnyObject) {
        OctoPrint.jog(ip!, apikey: apikey!, axis: "z", amount: jogIncrement)
    }
    
    @IBAction func jogZDown(sender: AnyObject) {
        OctoPrint.jog(ip!, apikey: apikey!, axis: "z", amount: -jogIncrement)
    }
    
    @IBAction func fansOn(sender: AnyObject) {
        OctoPrint.sendGcode("M106", ip: ip!, apikey: apikey!)
    }

    @IBAction func fansOff(sender: AnyObject) {
        OctoPrint.sendGcode("M106 S0", ip: ip!, apikey: apikey!)
    }
    
    @IBAction func motorsOff(sender: AnyObject) {
        OctoPrint.sendGcode("M18", ip: ip!, apikey: apikey!)
    }
    
    @IBAction func extruderOneChange(sender: AnyObject) {
        extruderOneTemp = Int(extruderOneSlider.value)
        extruderOneLabel.text = String(extruderOneTemp)
    }
   
    @IBAction func bedTempChange(sender: AnyObject) {
        bedTemp = Int(bedSlider.value)
        bedLabel.text = String(bedTemp)
    }
    
    @IBAction func setTempExtruderOne(sender: AnyObject) {
        OctoPrint.sendGcode("M104 S\(extruderOneTemp)", ip: ip!, apikey: apikey!)
    }
    
    @IBAction func setTempBed(sender: AnyObject) {
        OctoPrint.sendGcode("M140 S\(bedTemp)", ip: ip!, apikey: apikey!)
    }
    
    @IBAction func incrementChange(sender: AnyObject) {
        switch(increment.selectedSegmentIndex){
            case 0:
                jogIncrement = 0.1;
                break;
            case 1:
                jogIncrement = 1.0;
                break;
            case 2:
                jogIncrement = 10.0;
                break;
            case 3:
                jogIncrement = 100.0;
                break;
            default:
                break;
            }
        }
    @IBAction func extrude(sender: AnyObject) {
        var extrudeLength = filamentLength.text
        OctoPrint.sendGcode("G1 E \(extrudeLength)", ip: ip!, apikey: apikey!)
        self.view.endEditing(true)
    }
    
    @IBAction func retract(sender: AnyObject) {
        var retractLength = filamentLength.text
        OctoPrint.sendGcode("G1 E -\(retractLength)", ip: ip!, apikey: apikey!)
        self.view.endEditing(true)
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
}