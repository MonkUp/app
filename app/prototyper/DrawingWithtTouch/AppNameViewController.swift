import UIKit

class AppNameViewController: UIViewController {

    @IBOutlet weak var appNameInput: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AppNameViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.view.addBackground()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //When users names app and moves on
    @IBAction func appNameButtonPressed(sender: AnyObject) {
        APPNAME = appNameInput.text!
        print("pressed go!")
    }
    
    
    func dismissKeyboard() {
        view.endEditing(true)
    }


}
