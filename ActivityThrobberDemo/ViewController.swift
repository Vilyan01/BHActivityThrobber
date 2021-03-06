//
//  ViewController.swift
//  ActivityThrobberDemo
//
//  Created by Brian Heller on 11/1/15.
//  Copyright © 2015 Reaper Sofware Solution. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let throbber = BHActivityThrobber()

    override func viewDidLoad() {
        super.viewDidLoad()
        throbber.parentVC = self.view
        throbber.fillColor = self.view.backgroundColor?.colorWithAlphaComponent(0.8)
        throbber.setup()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startThrobber(sender: AnyObject) {
        throbber.startAnimation()
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(5.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            self.throbber.stopAnimation()
        })
    }


}

