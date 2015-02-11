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
    
    class func getHtml(ip:String) -> String{
        let urlString = "http://\(ip)"
        let url = NSURL(string: urlString)
        
        var error: NSError?
        let outputHtml = NSString(contentsOfURL: url!, encoding: NSUTF8StringEncoding, error: &error)
        
        if let error = error {
            println("Error : \(error)")
        } else {
            println("HTML : \(outputHtml)")
            println("it works")
        }
        
        return outputHtml!
    }
    
    class func stringBetweenStrings(original:String, from:String, to:String) -> String{
        let range = original.rangeOfString("(?<=\(from))[^.]+(?=\(to))", options:.RegularExpressionSearch)
        var result = ""
        
        if range != nil {
            let result = original.substringWithRange(range!)
            println("found: \(result)")
        }
        return result
    }
    
    class func getTerminalOutput() -> String {
        let ip = userDefaults.stringForKey("ip")
        let apikey = userDefaults.stringForKey("apikey")
        
//        var socket = WebSocket(url: NSURL(scheme: "ws", host: "http://\(ip)", path: "/#term")!)
//        //socket.delegate = self
//        //socket.connect()
//        
//
//        if socket.isConnected {
//            println("success")
//        }
        
        return "terminal output"
    }
    
    class func getTemp() -> String{
        let ip = userDefaults.stringForKey("ip")
        var html = getHtml(ip!)
        
        //GET request to /api/printer
        
        let output = stringBetweenStrings(html, from: "formatTemperature>", to: "</td>")
        
        return output
    }
    
    class func testConnection(ip:String, apikey:String) -> Bool{
        var connected = false
        
        let urlPath: String = "http://\(ip)/api/version"
        var url: NSURL = NSURL(string: urlPath)!
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(apikey, forHTTPHeaderField: "X-Api-Key")
        var response: NSURLResponse?
        
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil) as NSData?

        let httpResponse = response as? NSHTTPURLResponse
        
        if httpResponse?.statusCode == 200 {
            connected = true
            println("connected")
        } else {
            connected = false
            println("not connected")
        }
        
        println(connected)
        
        return connected
    }
}