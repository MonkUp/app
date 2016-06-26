//
//  DrawViewController.swift
//  DrawingWithTouch
//
//  Created by Sahas D on 6/25/16.
//
//

import UIKit

struct userScreenButton {
    let href: String
    let width: Int
    let height: Int
    let top: Int
    let left: Int
}

class DrawViewController: UIViewController {
    
    var drawView = DrawView_Smoothing(frame: CGRect(x: 10, y: 10, width: 10, height: 10), Int32(WIDTH), andHeight: Int32(HEIGHT))
    var isNewScreen : Bool = true;
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationController!.navigationBar.translucent = false;  //Ensure canvas is really in center
        
        //Adding whiteboard canvas
        self.view.backgroundColor = UIColor(red:0.36, green:0.36, blue:0.40, alpha:1.00)
        
        //Set center of canvas
        drawView.center = CGPointMake(self.view.frame.size.width/2, (self.view.frame.size.height/2));
        
        print(isNewScreen)
        if (isNewScreen == true) {
            drawView.title = self.title
            self.view!.addSubview(drawView)
            CANVASES.append(drawView);
        }
        else if (isNewScreen == false) {
            self.title = self.drawView.title;
            
        }
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addScreen))
    }
    @IBAction func saveButtonPressed(sender: AnyObject) {
        print("saved image")
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.drawView.bounds.width, self.drawView.bounds.height), true, 2.0 )
        self.drawView.drawViewHierarchyInRect(CGRect(x: 0, y: 0, width: self.drawView.bounds.width, height: self.drawView.bounds.height), afterScreenUpdates: false)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        self.drawView.screenImage = newImage
        
    }
    @IBAction func eraser(sender: AnyObject) {
        self.drawView.eraser()
    }
    @IBAction func pen(sender: AnyObject) {
        self.drawView.pen()
    }
    
    @IBAction func addCustomButton(sender: AnyObject) {
        print("GOT TO ADD SCREEN")
        if #available(iOS 8.0, *) {
            let ac = UIAlertController(title: "Enter Screen Name", message: nil, preferredStyle: .Alert)
            ac.addTextFieldWithConfigurationHandler(nil)
            let submitAction = UIAlertAction(title: "Submit", style: .Default) { [unowned self, ac] (action: UIAlertAction!) in
                self.createCustomButtom(ac.textFields![0].text!)
            }
            ac.addAction(submitAction)
            presentViewController(ac, animated: true, completion: nil)
        }
    }
    func createCustomButtom (sender: String) {
        print("Created custom \(sender)");
    }
    
}