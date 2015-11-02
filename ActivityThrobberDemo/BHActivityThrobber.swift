//
//  BHActivityThrobber.swift
//  ActivityThrobberDemo
//
//  Created by Brian Heller on 11/1/15.
//  Copyright © 2015 Reaper Sofware Solution. All rights reserved.
//

import UIKit

class BHActivityThrobber: UIView {

    var parentVC:UIView?
    var blurView:UIVisualEffectView!
    var container:UIView?
    let throbberRects = NSMutableArray()
    var fillColor:UIColor?
    let collapsedFrames = NSMutableArray()
    let extendedFrames = NSMutableArray()
    var throbber0collapsedFrame:CGRect?
    var throbber1collapsedFrame:CGRect?
    var throbber2collapsedFrame:CGRect?
    var throbber0extendedFrame:CGRect?
    var throbber1extendedFrame:CGRect?
    var throbber2extendedFrame:CGRect?
    var stop = false
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        self.hidden = true
    }
    
    func startAnimation() {
        // blur things out
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = parentVC!.frame
        parentVC?.addSubview(blurView)
        // the throbber container
        let containerCenter = CGPoint(x: parentVC!.center.x - 25, y: parentVC!.center.y - 25)
        let containerFrame = CGRect(origin: containerCenter, size: CGSize(width: 50, height: 50))
        container = UIView(frame: containerFrame)
        container!.backgroundColor = UIColor.whiteColor()
        container!.layer.borderColor = parentVC?.backgroundColor?.CGColor
        container!.layer.borderWidth = 2.0
        container!.layer.cornerRadius = 5.0
        // squares
        let borderUIColor = parentVC?.backgroundColor?.CGColor
        throbber0collapsedFrame = CGRect(x: 5.0, y: 20.0, width: 10.0, height: 10.0)
        throbber0extendedFrame = CGRect(x: 5.0, y: 5.0, width: 10.0, height: 40.0)
        collapsedFrames.addObject(NSValue(CGRect: throbber0collapsedFrame!))
        extendedFrames.addObject(NSValue(CGRect: throbber0extendedFrame!))
        let rect0 = UIImageView(frame: throbber0collapsedFrame!)
        rect0.layer.borderWidth = 1.0
        rect0.layer.borderColor = borderUIColor
        rect0.layer.cornerRadius = 2.0
        rect0.backgroundColor = self.fillColor
        throbberRects.addObject(rect0)
        throbber1collapsedFrame = CGRect(x: 20.0, y: 20.0, width: 10.0, height: 10.0)
        throbber1extendedFrame = CGRect(x: 20.0, y: 5.0, width: 10.0, height: 40.0)
        collapsedFrames.addObject(NSValue(CGRect: throbber1collapsedFrame!))
        extendedFrames.addObject(NSValue(CGRect: throbber1extendedFrame!))
        let rect1 = UIImageView(frame: throbber1collapsedFrame!)
        rect1.layer.borderWidth = 1.0
        rect1.layer.borderColor = borderUIColor
        rect1.layer.cornerRadius = 2.0
        rect1.backgroundColor = self.fillColor
        throbberRects.addObject(rect1)
        throbber2collapsedFrame = CGRect(x: 35.0, y: 20.0, width: 10.0, height: 10.0)
        throbber2extendedFrame = CGRect(x: 35.0, y: 5.0, width: 10.0, height: 40.0)
        collapsedFrames.addObject(NSValue(CGRect: throbber2collapsedFrame!))
        extendedFrames.addObject(NSValue(CGRect: throbber2extendedFrame!))
        let rect2 = UIImageView(frame: throbber2collapsedFrame!)
        rect2.layer.borderWidth = 1.0
        rect2.layer.borderColor = borderUIColor
        rect2.layer.cornerRadius = 2.0
        rect2.backgroundColor = self.fillColor
        throbberRects.addObject(rect2)
        container?.addSubview(rect0)
        container?.addSubview(rect1)
        container?.addSubview(rect2)
        parentVC?.addSubview(container!)
        startThrobbing(1)
        
    }
    
    func stopAnimation() {
        self.stop = true
    }
    
    func setFillColor(red:CGFloat, green:CGFloat, blue:CGFloat) {
        self.fillColor = UIColor(red: red, green: green, blue: blue, alpha: 0.8)
    }


}

// #MARK - Private Functions
extension BHActivityThrobber {
    private func startThrobbing(ind:Int) {
        let curIndex = ind % 3
        let prevIndex = (ind - 1) % 3
        let curThrobber = throbberRects.objectAtIndex(curIndex) as! UIImageView
        let prevThrobber = throbberRects.objectAtIndex(prevIndex) as! UIImageView
        let grow = extendedFrames.objectAtIndex(curIndex).CGRectValue
        let shrink = collapsedFrames.objectAtIndex(prevIndex).CGRectValue
        UIView.animateWithDuration(0.33, animations: { () -> Void in
            curThrobber.frame = grow
            prevThrobber.frame = shrink
            }) { (bool) -> Void in
                if(self.stop == false) {
                    self.startThrobbing(ind + 1)
                }
                else {
                    for square in self.throbberRects {
                        square.removeFromSuperview()
                    }
                    self.container?.removeFromSuperview()
                    NSLog("removing blur")
                    self.blurView?.removeFromSuperview()
                    NSLog("blur removed")
                    self.stop = false
                }
        }
        
    }
}
