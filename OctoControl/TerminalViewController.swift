//
//  TerminalViewController.swift
//  OctoControl
//
//  Created by quillford on 2/6/15.
//  Copyright (c) 2015 quillford. All rights reserved.
//

import UIKit

class TerminalViewController: UIViewController {

    @IBOutlet weak var commandField: UITextField!
    @IBOutlet weak var terminalOutput: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //OctoPrint.getTerminalOutput()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sendCommand(sender: AnyObject) {
        let ip = userDefaults.stringForKey("ip")
        let apikey = userDefaults.stringForKey("apikey")
        
        OctoPrint.sendGcode(commandField.text, ip: ip!, apikey: apikey!)
        
        //dismiss keyboard
        self.view.endEditing(true)
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
}

