//
//  SignUp2ViewController.swift
//  Alicorn
//
//  Created by Mac on 19/05/23.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import DTTextField

class SignUp2ViewController: UIViewController {
    
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var stackView : UIStackView!
    @IBOutlet weak var fullNameTF : UITextField!
    @IBOutlet weak var mobile1TF : UITextField!
    @IBOutlet weak var mobile2TF : UITextField!
    @IBOutlet weak var emailTF : UITextField!
    @IBOutlet weak var companyWebsiteTF : UITextField!
    @IBOutlet weak var passwordTF : UITextField!
    @IBOutlet weak var tmsTF : UITextField!
    @IBOutlet weak var joinTF : UITextField!
    @IBOutlet weak var monthlyShipTF : UITextField!
    @IBOutlet weak var whichcompanyTF : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

//        fullNameTF.label.text = "Phone number"
//        fullNameTF.placeholder = "555-555-5555"
//        fullNameTF.trailingAssistiveLabel.text = "This is helper text"
        
 
        
        
    }
    
    //MARK:- backBtnAction()
    @IBAction func backBtnAction (_ sender : UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continueBtnAction (_ sender : UIButton)
    {
        if fullNameTF.text == ""
        {
//            fullNameTF.borderColor = .red
//            fullNameTF.leadingAssistiveLabel.text = "Enter full name"
//            fullNameTF.leadingAssistiveLabel.textColor = .red
            
            
        }
        else{
//            fullNameTF.borderColor = .lightGray
//            fullNameTF.leadingAssistiveLabel.text = ""
        }
    }

    
}
extension SignUp2ViewController : UITextFieldDelegate {
    
    
}
