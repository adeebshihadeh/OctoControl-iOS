//
//  SettingsViewController.swift
//  OctoControl
//
//  Created by quillford on 2/6/15.
//  Copyright (c) 2015 quillford. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var ipField: UITextField!
    @IBOutlet weak var apikeyField: UITextField!
    
    var userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get previous stored values
        self.ipField.text = userDefaults.stringForKey("ip")
        self.apikeyField.text = userDefaults.stringForKey("apikey")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func setIP(sender: AnyObject) {
        //save the ip address
        userDefaults.setObject(self.ipField.text, forKey: "ip")
        //dismiss keyboard
        self.view.endEditing(true)
    }

    @IBAction func setApikey(sender: AnyObject) {
        //save the api key
        userDefaults.setObject(self.apikeyField.text, forKey: "apikey")
        //dismiss the keyboard
        self.view.endEditing(true)
    }
}
