//
//  SignUpViewController.swift
//  Alicorn
//
//  Created by Mac on 03/05/23.
//

import UIKit
import Alamofire
import MBProgressHUD


class SignUpViewController: UIViewController {
    var dummyTF = UITextField()
    @IBOutlet weak var contactTB : UITableView!
    var placeholerArray = ["FULL NAME", "MOBILE", "SECONDARY MOBILE", "EMAIL", "COMPANY WEBSITE", "PASSWORD", "TMS SYSTEM", "WHY DO YOU WANT TO JOIN ALICORN?", "APPRX MONTHLY SHIPPINGS?", "WHICH COMPANY SHIPPINGS?"]
    
    var fullName = "B"
    var mobile = ""
    var email = ""
    var error = false
    var errorIndex = 100
    var arrayOfCell = [ContactTableViewCell]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.contactTB.dataSource = self
        self.contactTB.dataSource = self
        
        self.contactTB.register(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactTableViewCell")
        
        self.dummyTF.delegate = self
    }
    
    //MARK:- backBtnAction()
    @IBAction func backBtnAction (_ sender : UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continueBtnAction (_ sender : UIButton)
    {
        
        //        error = true
                
        //        let businessVC = self.storyboard?.instantiateViewController(identifier: "BusinessTypeViewController") as! BusinessTypeViewController
        //        self.navigationController?.pushViewController(businessVC, animated: true)
        
        for i in 0..<arrayOfCell.count{
                if arrayOfCell[i].contactTF.hasText != true{
                    print(arrayOfCell[i].contactTF.text as Any)
                    print(i)
//                    error = true
//                    let indexPathRow:Int = i
//                    let indexPosition = IndexPath(row: indexPathRow, section: 0)
//                    self.contactTB.reloadRows(at: [indexPosition], with: .none)
//                    let alert = UIAlertController(title: "Warning!", message: "Please enter the text No: \(i)", preferredStyle: UIAlertController.Style.alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
//                    self.present(alert, animated: true, completion: nil)
                }
            }
       
        if Reachability.isConnectedToNetwork()
        {
//            signUpAPICall()
        }
        else
        {
            showToast(message: "Please check your Internet connection")
        }
    }
}

extension SignUpViewController : UITableViewDelegate, UITableViewDataSource {
    
    //MARK:- Tableview Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.placeholerArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as! ContactTableViewCell
        cell.placeholerLbl.text = placeholerArray[indexPath.row]
        arrayOfCell += [cell]
        cell.contactTF.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90
    }
    
}


extension SignUpViewController : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField.tag == 1){
            textField.keyboardType = .namePhonePad
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if (textField.tag == 0){
            fullName = textField.text ?? ""

        }
        if (textField.tag == 1){
            mobile = textField.text ?? ""

        }
        if (textField.tag == 3){
            email = textField.text ?? ""

        }
    }
}

extension SignUpViewController {
    
    func signUpAPICall()
    {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let registrationParams = SignUpRequestModel(firstname: "testone", phone: "9999999999", phone2: "6666666666", email: "testapis1@gmail.com", cwebsite: "est.com", password: "12341234", tmsSystem: "tms", joinAlicorn: "join", monthlyShipping: "shipping", whichCompanyShipping: "company")
        
        let jsonData = try! JSONEncoder().encode(registrationParams)
        let params = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any]
        print(params!)
        
        AF.request(baseURL + signUpAPI, method: .post, parameters: registrationParams, encoder: JSONParameterEncoder.default, headers: headers).response { [self] response in
            MBProgressHUD.hide(for: self.view, animated: true)
            switch response.result {
            case .success:
                print(response.response?.statusCode as Any)
                if (response.response?.statusCode == 200)
                {
                    guard let signUpResponse = try? JSONDecoder().decode(SignUpResponseModel.self, from: response.data!) else { return }
                    print(signUpResponse.data?.user?.email ?? "")
                    print(signUpResponse.message ?? "12")
                    UserDefaults.standard.set(signUpResponse.data?.token, forKey: k_token)
                }
                else
                {
                    let jsonResponse = try! JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as? [String: Any]
                    print(jsonResponse?["message"] as Any)
                    self.showToast(message: jsonResponse?["message"] as! String )
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


