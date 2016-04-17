//
//  ViewController.swift
//  Level Up
//
//  Created by Brian Farnsworth on 4/17/16.
//  Copyright © 2016 Brian Farnsworth. All rights reserved.
//
//
//  Resources: 
//  https://www.raywenderlich.com/115695/getting-started-with-core-data-tutorial
//  print("name \(name))")
//
//  TODO:
//      Make the sharedcode take a param that is the context, so I don't have to pass it everywhere
//

import UIKit
import CoreData

class ViewController: UIViewController {

    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
    let sharedCode = SharedCode();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        let managedContext = appDelegate.managedObjectContext;
        sharedCode.loadQualities(managedContext, name: "Happiness", setLabel: setLabel);
    }
    
    @IBOutlet weak var happinessCountLabel: UILabel!
    @IBAction func didClickHappinessButton(sender: UIButton) {
        let managedContext = appDelegate.managedObjectContext;
        sharedCode.incrementQuality(managedContext, qualityName: "Happiness", setLabel: setLabel);
    }
    @IBAction func didClickCreateSelfRespectButton(sender: UIButton) {
        let managedContext = appDelegate.managedObjectContext;
        sharedCode.createNewQuality(managedContext, name: "Self-Respect");
    }
    
    func setLabel(count: Int){
        happinessCountLabel.text = String(count);
    }
    
}//End of class

