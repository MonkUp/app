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

var BUTTON_CONTENTS : [String: [[String: String]]] = [:]

class DrawViewController: UIViewController {
    
    var drawView = DrawView_Smoothing(frame: CGRect(x: 10, y: 10, width: 10, height: 10), Int32(WIDTH), andHeight: Int32(HEIGHT))
    var isNewScreen : Bool = true;
    var button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
    var myButtons : [userScreenButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.translucent = false;  //Ensure canvas is really in center
        
        //Adding whiteboard canvas
        self.view.backgroundColor = UIColor(red:0.36, green:0.36, blue:0.40, alpha:1.00)
        
        //Set center of canvas
        drawView.center = CGPointMake(self.view.frame.size.width/2, (self.view.frame.size.height/2));
        
        //print(isNewScreen)
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
        print(newImage)
    
        
        var myArray = [[String: String]]()
        
        for i in 0...(myButtons.count-1) {
            // print("\(i) IS THE VALUE OF I IN THE FOR LOOPS")
            myArray.append([
                "href" : myButtons[i].href,
                "width" : String(myButtons[i].width),
                "height" : String(myButtons[i].height),
                "top" : String(myButtons[i].top),
                "left": String(myButtons[i].left)
            ])
        }
        BUTTON_CONTENTS.updateValue(myArray, forKey: self.title!)
        
        
        let imageData: NSData = UIImagePNGRepresentation(self.drawView.screenImage)!
        print(imageData)
        let strBase64:String = imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        print(strBase64);
        let MYURL : String = "http://monkup-avikj.rhcloud.com/api/image/\(USERNAME)/\(APPNAME)/\(self.drawView.title)"
        print(MYURL)
        //let params = "{\"data\":\"\(strBase64)\"}"
        //print(params)
        
        
        print("GOT HERE");
        let request = NSMutableURLRequest(URL: (NSURL(string: MYURL))!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = strBase64.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
        }
        task.resume()
        
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
        button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.layer.borderWidth = 1;
        button.backgroundColor = UIColor.clearColor();
        button.setTitle(sender, forState: .Normal)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(DrawViewController.handlePan(_:)))
        button.addGestureRecognizer(pan)
        
        let lp = UILongPressGestureRecognizer(target: self, action: #selector(DrawViewController.handleLp(_:)))
        button.addGestureRecognizer(lp)
        
        button.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)

        self.view.addSubview(button)
        
        
    }
    
    func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x, y:view.center.y + translation.y)
            print(view.center);
        }
        recognizer.setTranslation(CGPointZero, inView: self.view)
    }
    
    func handleLp(recognizer:UILongPressGestureRecognizer) {
        print("hard pressed")
        self.button.frame.size.height *= 1.2;
        self.button.frame.size.width *= 1.2
    }
    
    func buttonAction(sender: UIButton!) {
        let heightPercent = 100*self.button.frame.height/self.drawView.frame.height;
        let widthPercent = 100*self.button.frame.width/self.drawView.frame.width;
        
        let drawViewLeftPix = drawView.center.x-drawView.frame.width/2;
        let drawViewTopPix = drawView.center.y-drawView.frame.height/2;
        let centerxPercent = (self.button.center.x-drawViewLeftPix)*100/self.drawView.frame.width;
        let centeryPercent = (self.button.center.y-drawViewTopPix)*100/self.drawView.frame.height;
        
        let leftPercent = centerxPercent - widthPercent/2;
        let topPercent = centeryPercent - heightPercent/2;
        
        let buttonData = userScreenButton(href: (self.button.titleLabel?.text!)!, width: Int(widthPercent), height: Int(heightPercent), top: Int(topPercent), left: Int(leftPercent))
        
        //print(buttonData);
        self.myButtons.append(buttonData)
        self.button.titleLabel?.text //href
        button.enabled = false;
        
    }
    
}