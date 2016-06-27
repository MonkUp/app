//
//  UserScreensCollectionViewController.swift
//  DrawingWithTouch
//
//  Created by Sahas D on 6/25/16.
//
//

import UIKit
import Alamofire

private let reuseIdentifier = "Cell"
var APPDATA : [String:AnyObject] = [:]
var TEMPDATA : [String:AnyObject] = [:]

class UserScreensCollectionViewController: UICollectionViewController {
    
    var upcomingScreenTitle : String = "unanmed"
    var currentItem : Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.title = "\(APPNAME) screens"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addScreen))
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        print("REFRESHED DATA")
        super.viewDidAppear(animated)
        self.collectionView?.reloadData()
    }
    
    func addScreen() {
        print("GOT TO ADD SCREEN")
        if #available(iOS 8.0, *) {
            let ac = UIAlertController(title: "Enter Screen Name", message: nil, preferredStyle: .Alert)
            ac.addTextFieldWithConfigurationHandler(nil)
            let submitAction = UIAlertAction(title: "Submit", style: .Default) { [unowned self, ac] (action: UIAlertAction!) in
                self.upcomingScreenTitle = ac.textFields![0].text!
                self.performSegueWithIdentifier("GoToNewScreen", sender: nil)

                 
            }
            ac.addAction(submitAction)
            presentViewController(ac, animated: true, completion: nil)
        }
        
    }


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoToNewScreen" {
            let VC : UIViewController = segue.destinationViewController as UIViewController
            VC.title = upcomingScreenTitle
        }
        else if segue.identifier == "GoToExistingScreen" {
            let nav : UINavigationController = segue.destinationViewController as! UINavigationController
            let VC : DrawViewController = nav.topViewController as! DrawViewController
            VC.isNewScreen = false
            VC.view.addSubview(CANVASES[currentItem])
        }
    }


    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("\(CANVASES.count)")
        return CANVASES.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ScreenCell", forIndexPath: indexPath) as! ScreenCollectionViewCell
        
        cell.screenNameLabel.text = CANVASES[indexPath.item].title
        cell.screenImage.image = CANVASES[indexPath.item].screenImage
        //cell.screenNameLabel.textColor = UIColor.whiteColor()
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        currentItem = indexPath.item;
        self.performSegueWithIdentifier("GoToExistingScreen", sender: nil)
    }

    @IBAction func uploadToServer(sender: AnyObject) {
        APPDATA["username"] = USERNAME;
        APPDATA["appName"] = APPNAME;
        APPDATA["initialViewName"] = CANVASES[0].title
        var viewsArray: Array<[String: AnyObject]> = Array<[String: AnyObject]>();
        for canva in 0...CANVASES.count-1 {
            TEMPDATA["viewname"] = CANVASES[canva].title
            TEMPDATA["buttons"] = BUTTON_CONTENTS[CANVASES[canva].title]
            viewsArray.append(TEMPDATA);
        }
        var postString : NSString = " "
        APPDATA["views"] = viewsArray;
        print(APPDATA)
        do{
            let jsonData = try NSJSONSerialization.dataWithJSONObject(APPDATA, options: NSJSONWritingOptions.PrettyPrinted);
            //print(jsonData)
            postString = NSString(data: jsonData, encoding: NSUTF8StringEncoding)!
            print(postString)
            

        }catch _ {
            
        }
        let request = NSMutableURLRequest(URL: NSURL(string: "http://monkup-avikj.rhcloud.com/api/appData")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
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
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: Any?) {
    
    }
    */

}
