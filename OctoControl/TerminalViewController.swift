//
//  TerminalViewController.swift
//  OctoControl
//
//  Created by quillford on 2/6/15.
//  Copyright (c) 2015 quillford. All rights reserved.
//

import UIKit
import Starscream

class TerminalViewController: UIViewController, WebSocketDelegate {
    
    var socket = WebSocket(url: NSURL(scheme: "ws", host: "prusa.local", path: "/sockjs/websocket")!)
    
    let ip = userDefaults.stringForKey("ip")
    let apikey = userDefaults.stringForKey("apikey")

    @IBOutlet weak var commandField: UITextField!
    @IBOutlet weak var terminalOutput: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        socket.delegate = self
        socket.connect()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sendCommand(sender: AnyObject) {
        OctoPrint.sendGcode(commandField.text, ip: ip!, apikey: apikey!)
        
        //dismiss keyboard
        self.view.endEditing(true)
    }
    
    func updateTerminal(){
        //get terminal output from websocket data
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func websocketDidConnect(ws: WebSocket) {
        println("websocket is connected")
    }
    
    func websocketDidDisconnect(ws: WebSocket, error: NSError?) {
        if let e = error {
            println("websocket is disconnected: \(e.localizedDescription)")
        }
    }
    
    func websocketDidReceiveMessage(ws: WebSocket, text: String) {
        println("Received text: \(text)")
    }
    
    func websocketDidReceiveData(ws: WebSocket, data: NSData) {
        println("Received data: \(data.length)")
    }
}

