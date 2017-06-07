//
//  ViewController.swift
//  NFCenter
//
//  Created by Keaton Burleson on 6/5/17.
//  Copyright © 2017 Keaton Burleson. All rights reserved.
//

import UIKit
import CoreNFC

class ViewController: UIViewController, NFCNDEFReaderSessionDelegate {
    var nfcSession: NFCNDEFReaderSession? = nil
    var newLog = true
    @IBOutlet var logArea: UITextView?
    
    
    
    /* MARK: NFCNDEFReaderSessionDelegate */
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        appendLog(newText: ["Error", error.localizedDescription])
        stopScanning()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        for message in messages {
            for record in message.records {
                print(record.identifier)
                print(record.payload)
                print(record.type)
                print(record.typeNameFormat)
                appendLog(newText: [String(describing: record.identifier), String(describing: record.payload), String(describing: record.type), String(describing: record.typeNameFormat)])
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logArea?.layer.cornerRadius = 10
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func beginScanning() {
        if nfcSession == nil {
            nfcSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        }
        nfcSession?.begin()
    }
    
    func stopScanning() {
        nfcSession?.invalidate()
        nfcSession = nil
    }
    
    func appendLog(newText: [String]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .medium
        
        // Call main thread since the NFC thread is background!
        DispatchQueue.main.sync {
            if newLog == true{
                logArea?.text = ""
                newLog = false
            }
            logArea?.text.append(dateFormatter.string(from: Date()) + " ")
            for string in newText {
                logArea?.text.append(string + " ")
            }
            logArea?.text.append("\n")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        stopScanning()
        // Dispose of any resources that can be recreated.
    }


}

