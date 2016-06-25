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
            WIDTH = 325; HEIGHT = 667;
        case 1:
            print("selected ipad");
            //WIDTH = 540; HEIGHT = 500  //ratio 16 : 9
        case 2:
            print("selected web");
            //WIDTH = 650; HEIGHT = 0123; //ratio 16 : 9
        default:
            print("we got an error");
        }
    }
}
