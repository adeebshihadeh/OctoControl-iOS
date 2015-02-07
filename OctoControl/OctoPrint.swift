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
//    let ip = userDefaults.stringForKey("ip")
//    let apikey = userDefaults.stringForKey("apikey")
    
    class func sendGcode(command:String, ip:String, apikey:String){
    
        var request = NSMutableURLRequest(URL: NSURL(string: "http://\(ip)/api/printer/command")!)
        request.HTTPMethod = "POST"
        
        var dataString = "{\"command\":\"\(command)\"}"
        var requestBodyData: NSData = (dataString as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
        
        request.addValue((String(countElements(dataString))), forHTTPHeaderField: "Content-Length")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(apikey, forHTTPHeaderField: "X-Api-Key")
        
        request.HTTPBody = requestBodyData
        
        var connection = NSURLConnection(request: request, delegate: self, startImmediately: true)
        
        println("sending POST request")
        
        println("IP: \(ip)\napikey: \(apikey)\ndatastring: \(dataString)\ncontent length: \(String(countElements(dataString)))\n")
        
        connection?.start()
    }
    
    class func getTerminalOutput(ip: String) {
        let urlString = ip
        let url = NSURL(string: urlString)
        
        var error: NSError?
        let outputHtml = NSString(contentsOfURL: url!, encoding: NSUTF8StringEncoding, error: &error)
        
        if let error = error {
            println("Error : \(error)")
        } else {
            println("HTML : \(outputHtml)")
        }
        
    }
    
    class func jog(ip:String, apikey:String, axis:String, amount:Float) {
        var request = NSMutableURLRequest(URL: NSURL(string: "http://\(ip)/api/printer/printhead")!)
        request.HTTPMethod = "POST"
        
        var dataString = "{\"command\":\"jog\",\"\(axis)\":\(amount)}"
        var requestBodyData: NSData = (dataString as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
        
        request.addValue((String(countElements(dataString))), forHTTPHeaderField: "Content-Length")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(apikey, forHTTPHeaderField: "X-Api-Key")
        
        request.HTTPBody = requestBodyData
        
        var connection = NSURLConnection(request: request, delegate: self, startImmediately: true)
        
        println("sending POST request")
        
        connection?.start()
    }
}