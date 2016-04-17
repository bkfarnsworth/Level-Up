//
//  ViewController.swift
//  Level Up
//
//  Created by Brian Farnsworth on 4/17/16.
//  Copyright © 2016 Brian Farnsworth. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var qualities = [NSManagedObject]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

          print(qualities)
        
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
//        let managedContext = appDelegate.managedObjectContext;
//        let entity = NSEntityDescription.entityForName("Quality", inManagedObjectContext:managedContext);
//        let quality = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext);
//        
//        quality.setValue("Happiness", forKey: "name");
//        quality.setValue(0, forKey: "count");
        
//        do{
//            try managedContext.save();
//            qualities.append(quality);
//        } catch let error as NSError {
//            print("Could not save \(error), \(error.userInfo)")
//        }
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        let managedContext = appDelegate.managedObjectContext;
        let fetchRequest = NSFetchRequest(entityName: "Quality");
        
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            qualities = results as! [NSManagedObject]
            print("qualities \(qualities.count)")
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var count = 0;

    
    @IBOutlet weak var happinessCountLabel: UILabel!
    @IBAction func didClickHappinessButton(sender: UIButton) {
        count++;
        happinessCountLabel.text = String(count);
    }

}

