//
//  LoginViewController.swift
//  Alicorn
//
//  Created by Mac on 02/05/23.
//

import UIKit
import Alamofire
import MBProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userIDTF : UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var showPWDSwitch : UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        userIDTF.text = "kranti@gmail.com"
        passwordTF.text = "password"
    }
    
    
    @IBAction func showPWDSwitchAction(_ sender: Any) {
        if showPWDSwitch.isOn == true
        {
            self.passwordTF.isSecureTextEntry = false
        }
        else
        {
            self.passwordTF.isSecureTextEntry = true
        }
    }
    
    @IBAction func forgotUserIDBtnAction (_ sender : UIButton)
    {
        
    }
    
    @IBAction func signUpBtnAction (_ sender : UIButton)
    {
        self.moveToSignUp()
        
    }
    
    @IBAction func loginBtnAction (_ sender : UIButton)
    {
        if Reachability.isConnectedToNetwork() {
            if (self.userIDTF.text == "" || self.passwordTF.text == ""){
                showToast(message: "Please fill the required fields")
            }
            else
            {
                MBProgressHUD.showAdded(to: self.view, animated: true)
                let loginParameters = LoginRequestModel(email: self.userIDTF.text, password: self.passwordTF.text)
                AF.request(baseURL+loginAPI, method: .post, parameters: loginParameters, encoder: JSONParameterEncoder.default, headers: headers).response { loginResult in
                    MBProgressHUD.hide(for: self.view, animated: true)
                    if loginResult.response?.statusCode == 200
                    {   let loginResponseModel = try? JSONDecoder().decode(LoginResponseModel.self, from: loginResult.data!)
                        
                        print(":::: Login Sucessfull ::::")
                        print(loginResponseModel!.data!.token!)
                        self.showToast(message: loginResponseModel!.message!)
                        let loginToken = loginResponseModel!.data!.token!
                        authToken = loginResponseModel!.data!.token!
                        UserDefaults.standard.set(loginToken, forKey: k_token)
                        headers.update(name: "Authorization", value: "Bearer " + authToken)
//                        self.moveToHome()
                        self.moveToProductList()
                    }
                    else
                    {
                        let jsonResponse = try! JSONSerialization.jsonObject(with: loginResult.data!, options: .allowFragments) as? [String: Any]
                        print(jsonResponse?["message"] ?? "")
                        self.showToast(message: jsonResponse?["message"] as! String )
                    }
                }
            }
        }
        else
        {
            showToast(message: "Please check your Internet connection")
        }
        
    }
}
