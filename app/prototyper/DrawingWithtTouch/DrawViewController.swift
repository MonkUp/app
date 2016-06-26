//
//  DrawViewController.swift
//  DrawingWithTouch
//
//  Created by Sahas D on 6/25/16.
//
//

import UIKit


class DrawViewController: UIViewController {
    
    let drawView = DrawView_Smoothing(frame: CGRect(x: 10, y: 10, width: 10, height: 10), Int32(WIDTH), andHeight: Int32(HEIGHT))
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationController!.navigationBar.translucent = false;  //Ensure canvas is really in center
        
        //Adding whiteboard canvas
        self.view.backgroundColor = UIColor(red:0.36, green:0.36, blue:0.40, alpha:1.00)
        self.view!.addSubview(drawView)
        
        //Set center of canvas
        drawView.center = CGPointMake(self.view.frame.size.width/2, (self.view.frame.size.height/2));
        
        //Title of Canvas and View
        print("The title of the VC is \(self.title)")
        drawView.title = self.title
        print("The title of the DV is \(drawView.title)")

        
        CANVASES.append(drawView);
    }
    
}