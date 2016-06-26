import UIKit

class ScreenSizeSelectionViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func screenSizeSelected(sender: AnyObject) {
        print ("username is: \(USERNAME)");
        print ("appname is: \(APPNAME)");
        switch sender.tag {
        case 0:
            print("selected iphone");  //ratio 16 : 9
            WIDTH = 320; HEIGHT = 568;
        case 1:
            print("selected ipad");
            WIDTH = 600; HEIGHT = 450  //ratio 16 : 9
        case 2:
            print("selected web");
            WIDTH = 600; HEIGHT = 450; //ratio 16 : 9
        default:
            print("we got an error");
        }
    }
}
