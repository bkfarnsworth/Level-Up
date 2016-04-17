//
//  SharedCode.swift
//  Level Up
//
//  Created by Brian Farnsworth on 4/17/16.
//  Copyright © 2016 Brian Farnsworth. All rights reserved.
//

import Foundation
import CoreData

class SharedCode{
    
    var qualities = [NSManagedObject]();
    
    func loadQualities(managedContext: NSManagedObjectContext, name: String, setLabel: (Int) -> ()){
        
        let fetchRequest = NSFetchRequest(entityName: "Quality");
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest);
            qualities = results as! [NSManagedObject]
            
            for(var i = 0; i < qualities.count; i++){
                print("Printing")
                let quality = qualities[i];
                let qName = quality.valueForKey("name") as! String;
                let qCount = quality.valueForKey("count") as! Int;
                print("name \(qName)");
                print("count \(qCount)");
                
                if(qName == name){
                    setLabel(qCount);
                }
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }

    func incrementQuality(managedContext: NSManagedObjectContext, qualityName: String, setLabel: (Int) -> ()){
        let fetchRequest = NSFetchRequest(entityName: "Quality");
        fetchRequest.predicate = NSPredicate(format: "name = %@", qualityName);
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest);
            let queriedQualities = results as! [NSManagedObject];
            let quality = queriedQualities[0];
            let count = quality.valueForKey("count") as! Int;
            let newCount = count + 1;
            
            quality.setValue(newCount, forKey: "count");
            
            do{
                try managedContext.save();
                //TODO: still need to update the internal array  qualities.append(quality);
                //what is the best way to do this? Update the array and then call a render function?
            } catch let error as NSError {
                print("Could not save \(error), \(error.userInfo)")
            }
            
            setLabel(newCount);
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }

    func createNewQuality(managedContext: NSManagedObjectContext, name: String){
        let entity = NSEntityDescription.entityForName("Quality", inManagedObjectContext:managedContext);
        let quality = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext);
        
        quality.setValue(name, forKey: "name");
        quality.setValue(0, forKey: "count");
        
        do{
            try managedContext.save();
            qualities.append(quality);
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }//create new quality
    
    func deleteAllCoreData(managedContext: NSManagedObjectContext){
//        let appDel: foodforteethAppDelegate = UIApplication.sharedApplication().delegate as foodforteethAppDelegate
//        let context: NSManagedObjectContext = appDel.managedObjectContext
//        let request = NSFetchRequest(entityName: "Food")
//        
//        myList = context.executeFetchRequest(request, error: nil)
//        
//        
//        if let tv = tblTasks {
//            
//            var bas: NSManagedObject!
//            
//            for bas: AnyObject in myList
//            {
//                context.deleteObject(bas as NSManagedObject)
//            }
//            
//            myList.removeAll(keepCapacity: false)
//            
//            tv.reloadData()
//            context.save(nil)
//        }
    }

}