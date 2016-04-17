//
//  ViewController.swift
//  Level Up
//
//  Created by Brian Farnsworth on 4/17/16.
//  Copyright © 2016 Brian Farnsworth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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

