

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var user = "ilaha"
    var pass = "123"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        login()
    }

    @IBAction func loginButtonClicked(_ sender: Any) {
        
        if username.text == user && password.text == pass{
            
            let controller = storyboard?.instantiateViewController(identifier: "TabBarController") as! TabBarController
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true)
            
//            if let sceneDelegate = UIApplication.shared.delegate as? SceneDelegate {
//                            sceneDelegate.window?.rootViewController = controller
//                        }
        }
    }
    
    func login(){
        
        UserDefaults.standard.setValue(true, forKey: "loggedIn")
    }
    
}
