//
//  InterfaceController.swift
//  Level Up WatchKit Extension
//
//  Created by Brian Farnsworth on 4/17/16.
//  Copyright © 2016 Brian Farnsworth. All rights reserved.
//

import WatchKit
import Foundation
import CoreData

class InterfaceController: WKInterfaceController {

    let extensionDelegate = WKExtension.sharedExtension().delegate as? ExtensionDelegate;
    let sharedCode = SharedCode();
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate();
        let managedContext = extensionDelegate!.managedObjectContext;
        sharedCode.loadQualities(managedContext, name: "Self-Respect", setLabel: setLabel);
//        sharedCode.createNewQuality(managedContext);
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    var count = 0;
    @IBOutlet var happinessCountLabel: WKInterfaceLabel!
    @IBAction func didClickHappinessButton() {
        let managedContext = extensionDelegate!.managedObjectContext;
        sharedCode.incrementQuality(managedContext, qualityName: "Self-Respect",setLabel: setLabel);
    }
    @IBAction func didClickCreateSelfRespectButton() {
        let managedContext = extensionDelegate!.managedObjectContext;
        sharedCode.createNewQuality(managedContext, name: "Self-Respect")
    }
    
    func setLabel(count: Int){
//        print("count \(count)")
        happinessCountLabel.setText(String(count));
    }
}//end of class
