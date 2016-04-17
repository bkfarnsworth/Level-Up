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
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var qualities = [NSManagedObject]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        let managedContext = appDelegate.managedObjectContext;
        let fetchRequest = NSFetchRequest(entityName: "Quality");
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest);
            qualities = results as! [NSManagedObject]
            
            for(var i = 0; i < qualities.count; i++){
                print("Printing")
                let quality = qualities[i];
                let name = quality.valueForKey("name") as! String;
                let count = quality.valueForKey("count") as! Int;
                print("name \(name)");
                print("count \(count)");
                
                if(name == "Happiness"){
                    happinessCountLabel.text = String(count);
                }
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }

    @IBOutlet weak var happinessCountLabel: UILabel!
    @IBAction func didClickHappinessButton(sender: UIButton) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        let managedContext = appDelegate.managedObjectContext;
        let fetchRequest = NSFetchRequest(entityName: "Quality");
        fetchRequest.predicate = NSPredicate(format: "name = %@", "Happiness");
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest);
            let queriedQualities = results as! [NSManagedObject];
            let happiness = queriedQualities[0];
            let count = happiness.valueForKey("count") as! Int;
            let newCount = count + 1;
            
            happiness.setValue(newCount, forKey: "count");
            
            do{
                try managedContext.save();
                //TODO: still need to update the internal array  qualities.append(quality);
                //what is the best way to do this? Update the array and then call a render function?
            } catch let error as NSError {
                print("Could not save \(error), \(error.userInfo)")
            }
            
            happinessCountLabel.text = String(newCount);

        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func createNewQuality(){
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

    }//create new quality
    
}//End of class

