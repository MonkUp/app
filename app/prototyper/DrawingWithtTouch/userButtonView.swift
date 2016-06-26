//
//  userButtonView.swift
//  DrawingWithTouch
//
//  Created by Sahas D on 6/25/16.
//
//

import UIKit

class userButtonView: UIView {
    
    var lastLocation:CGPoint = CGPointMake(0, 0)
    let movable : Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        let panRecognizer = UIPanGestureRecognizer(target:self, action:#selector(userButtonView.detectPan(_:)))
        self.gestureRecognizers = [panRecognizer]
        self.backgroundColor = UIColor(red:1.00, green:0.80, blue:0.00, alpha:0.40)
        self.translatesAutoresizingMaskIntoConstraints = true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func detectPan(recognizer:UIPanGestureRecognizer) {
        if (movable) {
            let translation  = recognizer.translationInView(self.superview!)
            self.center = CGPointMake(lastLocation.x + translation.x, lastLocation.y + translation.y)
            print("\(self.center)")
        }
    }
    
    func detectPinch (recognizer: UIPinchGestureRecognizer) {
        self.transform = CGAffineTransformScale(self.transform, recognizer.scale, recognizer.scale)
        recognizer.scale = 1
        print("pinched!!!")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.superview?.bringSubviewToFront(self)
        lastLocation = self.center
    }
    
}