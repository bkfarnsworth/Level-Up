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

class ViewController: UITableViewController {

    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
    let sharedCode = SharedCode();
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        print("4")
        super.viewWillAppear(animated);
        let managedContext = appDelegate.managedObjectContext;
//        sharedCode.createNewQuality(managedContext, name: "Self-Respect");
//             sharedCode.createNewQuality(managedContext, name: "Balance");
//             sharedCode.createNewQuality(managedContext, name: "Courage");
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
//        happinessCountLabel.text = String(count);
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sharedCode.qualities.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        print("3")
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        //uncommenting this up here makes the selection animation work,
        //but the numbers don't update!
//        tableView.deselectRowAtIndexPath(indexPath, animated:false);
        
        print("row")
        print(indexPath.row)
        
        let managedContext = appDelegate.managedObjectContext;
        
        let quality = sharedCode.qualities[indexPath.row];
        let qualityName = quality.valueForKey("name") as! String;
        
        sharedCode.incrementQuality(managedContext, qualityName: qualityName, setLabel: setLabel);
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        configureCell(cell, atIndexPath: indexPath);
        
//        tableView.deselectRowAtIndexPath(indexPath, animated:true);
    }
    
    
//    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return false;
//    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let context = appDelegate.managedObjectContext;
//            context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject)
            
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                //print("Unresolved error \(error), \(error.userInfo)")
                abort()
            }
        }
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        
        print("something \(sharedCode.qualities.count)")
        let object = sharedCode.qualities[indexPath.row];
        let name = object.valueForKey("name") as! String;
        let count = object.valueForKey("count") as! Int;
        
        cell.textLabel!.text = name + " " + String(count);
    }
    
}//End of class

