//
//  OctoPrint.swift
//  OctoControl
//
//  Created by quillford on 2/6/15.
//  Copyright (c) 2015 quillford. All rights reserved.
//

import Foundation

var userDefaults = NSUserDefaults.standardUserDefaults()

class OctoPrint {
    var ip = userDefaults.stringForKey("ip")
    var apikey = userDefaults.stringForKey("apikey")
    
    var command = "feeder"
    
    func sendGcode(){

    }
}