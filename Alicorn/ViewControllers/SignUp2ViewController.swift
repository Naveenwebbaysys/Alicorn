//
//  SignUp2ViewController.swift
//  Alicorn
//
//  Created by Mac on 19/05/23.
//

import UIKit
import Alamofire
import MBProgressHUD

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
        guard isValidate() else { return }
        if Reachability.isConnectedToNetwork() 
            {
            registrationAPICall()
            }
            else
            {
                showToast(message: "Please check your Internet connection")
            }
            
        }
        
        
    func isValidate () -> Bool
    {
            if fullNameTF.text == ""
            {
                fullNameTF.borderColor = .red
                fullNameTF.borderWidth = 0.5
                fullNameTF.cornerRadius = 6
                showToast(message: "Please enter full name")
                return false
            }
            else{
                fullNameTF.borderWidth = 0
            }
            if mobile1TF.text == ""
            {
                mobile1TF.borderColor = .red
                mobile1TF.borderWidth = 0.5
                mobile1TF.cornerRadius = 6
                showToast(message: "Please enter mobile number")
                return false
            }
            else{
                mobile1TF.borderWidth = 0
            }
            if emailTF.text == ""
            {
                emailTF.borderColor = .red
                emailTF.borderWidth = 0.5
                emailTF.cornerRadius = 6
                showToast(message: "Please enter email")
                return false
            }
            else{
                emailTF.borderWidth = 0
            }
            if companyWebsiteTF.text == ""
            {
                companyWebsiteTF.borderColor = .red
                companyWebsiteTF.borderWidth = 0.5
                companyWebsiteTF.cornerRadius = 6
                showToast(message: "Please enter web site")
                return false
            }
            else{
                companyWebsiteTF.borderWidth = 0
            }
            if passwordTF.text == ""
            {
                passwordTF.borderColor = .red
                passwordTF.borderWidth = 0.5
                passwordTF.cornerRadius = 6
                showToast(message: "Please enter password")
                return false
            }
            else{
                passwordTF.borderWidth = 0
            }
            if tmsTF.text == ""
            {
                tmsTF.borderColor = .red
                tmsTF.borderWidth = 0.5
                tmsTF.cornerRadius = 6
                showToast(message: "Please enter TMS")
                return false
            }
            else{
                tmsTF.borderWidth = 0
            }
            if joinTF.text == ""
            {
                joinTF.borderColor = .red
                joinTF.borderWidth = 0.5
                joinTF.cornerRadius = 6
                showToast(message: "Please enter reason")
                return false
            }
            else{
                joinTF.borderWidth = 0
            }
            if monthlyShipTF.text == ""
            {
                monthlyShipTF.borderColor = .red
                monthlyShipTF.borderWidth = 0.5
                monthlyShipTF.cornerRadius = 6
                showToast(message: "Please enter shipping")
                return false
            }
            else{
                monthlyShipTF.borderWidth = 0
            }
            if whichcompanyTF.text == ""
            {
                whichcompanyTF.borderColor = .red
                whichcompanyTF.borderWidth = 0.5
                whichcompanyTF.cornerRadius = 6
                showToast(message: "Please enter company name")
                return false
            }
            else{
                whichcompanyTF.borderWidth = 0
            }
            return true
        }
        
        func registrationAPICall()
        {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            let registrationParameters = SignUpRequestModel(firstname: self.fullNameTF.text!, phone: self.mobile1TF.text!, phone2: self.mobile2TF.text!, email: self.emailTF.text!, cwebsite: self.companyWebsiteTF.text!, password: self.passwordTF.text!, tmsSystem: self.tmsTF.text!, joinAlicorn: self.joinTF.text!, monthlyShipping: self.monthlyShipTF.text!, whichCompanyShipping: self.whichcompanyTF.text!)
            MBProgressHUD.hide(for: self.view, animated: true)
            
            AF.request(baseURL + signUpAPI, method: .post, parameters: registrationParameters, encoder: JSONParameterEncoder.default, headers: headers).response { signUpResponse in
                
                if signUpResponse.response?.statusCode == 200
                {   let signUpResponseModel = try? JSONDecoder().decode(SignUpResponseModel.self, from: signUpResponse.data!)
                    
                    print(":::: Login Sucessfully ::::")
                    print(signUpResponseModel!.data!.token!)
                    let signUpToken = signUpResponseModel!.data!.token!
                    UserDefaults.standard.set(signUpToken, forKey: k_signUptoken)
                    self.showToast(message: signUpResponseModel!.message!)
                    self.moveToHome()
                    
                }
                else
                {
                    let jsonResponse = try! JSONSerialization.jsonObject(with: signUpResponse.data!, options: .allowFragments) as? [String: Any]
                    print(jsonResponse?["message"] ?? "")
                    self.showToast(message: jsonResponse?["message"] as! String )
                }
                
            }
        }
    }
    extension SignUp2ViewController : UITextFieldDelegate {
        
        
    }
