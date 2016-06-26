import UIKit

var USERNAME : String = "Sahas";
var APPNAME : String = "HELLO WORLD";
var HEIGHT : Int = 0;
var WIDTH : Int = 0;
var CANVASES = [DrawView_Smoothing]()

class enterUsernameViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(enterUsernameViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //When user hits go button
    @IBAction func enterButton(sender: AnyObject) {
        USERNAME = usernameField.text!
        print("hello world")
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}
