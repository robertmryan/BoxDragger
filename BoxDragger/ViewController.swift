//
//  ViewController.swift
//  BoxDragger
//
//  Created by Robert Ryan on 2/14/16.
//  Copyright © 2016 Robert Ryan. All rights reserved.
//

import UIKit

class AxisView: UIView {
    
    var pin:PinImageView?
    
    func drawAxis(from:CGPoint, to:CGPoint) {
        let context = UIGraphicsGetCurrentContext()
        switch pin!.id {
        case "redPinA", "redPinB":
            CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0)
        case "bluePinA", "bluePinB":
            CGContextSetRGBStrokeColor(context, 0.0, 0.0, 1.0, 1.0)
        default: break
        }
        
        /* line width of axes */
        CGContextSetLineWidth(context, 0.5)
        
        /* draw vertical axis inside magnifier */
        CGContextMoveToPoint(context, from.x, from.y)
        CGContextAddLineToPoint(context, to.x, to.y)
        
        /* draw horizontal axis inside magnifier */
        CGContextStrokePath(context)
    }
    
    override func drawRect(rect: CGRect) {
        if pin != nil {
            drawAxis(CGPointMake(pin!.center.x, frame.origin.y), to: CGPointMake(pin!.center.x, frame.origin.y + frame.height))
        }
    }
    
}


class PinImageView: UIImageView {
    
    var lastLocation:CGPoint!
    var id:String!
    var viewForAxis:AxisView!
    
    init(imageIcon: UIImage?, location:CGPoint, name:String, axisView:AxisView) {
        
        super.init(image: imageIcon)
        lastLocation = location
        id = name
        
        viewForAxis = axisView
        print(viewForAxis.frame.size)
        center = location
        frame = CGRect(x: location.x, y: location.y, width: 40.0, height: 60.0)
        
        userInteractionEnabled = true
        
        /*let pan = UIPanGestureRecognizer(target: self, action: "something:")
        addGestureRecognizer(pan)*/
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*func something(pan:UIPanGestureRecognizer) {
    print(viewForAxis.frame.size)
    viewForAxis.hidden = false
    viewForAxis.pin = self
    viewForAxis.drawAxis(CGPointMake(center.x, viewForAxis.frame.origin.y), to: (CGPointMake(center.x, viewForAxis.frame.origin.y + viewForAxis.frame.height)))
    }*/
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let _ = touches.first {
            print(viewForAxis.frame.size)
            viewForAxis.hidden = false
            viewForAxis.pin = self
            viewForAxis.setNeedsDisplay()
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        viewForAxis.hidden = true
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch: UITouch = touches.first {
            center = touch.locationInView(superview)
            viewForAxis.setNeedsDisplay()
        }
    }
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var axisView: AxisView!
    var redPinA: PinImageView!
    var redPinB: PinImageView!
    var bluePinA: PinImageView!
    var bluePinB: PinImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        axisView = AxisView()
        axisView.frame = view.bounds
        axisView.backgroundColor = UIColor.clearColor()
        
        scrollView.addSubview(axisView)
        axisView.hidden = true
        
        redPinA = PinImageView(imageIcon: UIImage(named: "red_pin.png"), location: CGPointMake(40, 110), name: "redPinA", axisView: axisView)
        
        redPinB = PinImageView(imageIcon: UIImage(named: "red_pin.png"), location: CGPointMake(80, 110), name: "redPinB", axisView: axisView)
        
        bluePinA = PinImageView(imageIcon: UIImage(named: "blue_pin.png"), location: CGPointMake(200, 110), name: "bluePinA", axisView: axisView)
        
        bluePinB = PinImageView(imageIcon: UIImage(named: "blue_pin.png"), location: CGPointMake(240, 110), name: "bluePinB", axisView: axisView)
        
        scrollView.addSubview(redPinA)
        scrollView.addSubview(redPinB)
        scrollView.addSubview(bluePinA)
        scrollView.addSubview(bluePinB)
    }
    
}

