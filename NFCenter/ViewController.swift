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
    
    /* MARK: NFCNDEFReaderSessionDelegate */
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print(error.localizedDescription)
        stopScanning()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        for message in messages {
            for record in message.records {
                print(record.identifier)
                print(record.payload)
                print(record.type)
                print(record.typeNameFormat)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        stopScanning()
        // Dispose of any resources that can be recreated.
    }


}

