//
//  GetStartedViewController.swift
//  Alicorn
//
//  Created by Mac on 09/05/23.
//

import UIKit

class GetStartedViewController: UIViewController {

    @IBOutlet weak var userAgreementBtn : UIButton!
    @IBOutlet weak var notificationBtn : UIButton!
    @IBOutlet weak var locationBtn : UIButton!
    @IBOutlet weak var cameraAccessBtn : UIButton!
    @IBOutlet weak var signUpAirCornBtn : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func backBtnAction (_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func getStartedBtnAction (_ sender : UIButton)
    {
        let searchVC = self.storyboard?.instantiateViewController(identifier: "SearchViewController") as! SearchViewController
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @IBAction func userAgreementAcion (_ sender: UIButton)
    {
        userAgreementBtn.setImage(UIImage(named: "Alicorn-app-35"), for: .normal)
        userAgreementBtn.isUserInteractionEnabled = false
        let agreementVC = self.storyboard?.instantiateViewController(identifier: "LicenceViewController") as! LicenceViewController
        self.navigationController?.pushViewController(agreementVC, animated: true)
    }
    @IBAction func notificationAcion (_ sender: UIButton)
    {
        notificationBtn.setImage(UIImage(named: "Alicorn-app-35"), for: .normal)
        notificationBtn.isUserInteractionEnabled = false
    }
    @IBAction func locationAcion (_ sender: UIButton)
    {
        locationBtn.setImage(UIImage(named: "Alicorn-app-35"), for: .normal)
        locationBtn.isUserInteractionEnabled = false
    }

    @IBAction func cameraAccessAcion (_ sender: UIButton)
    {
        cameraAccessBtn.setImage(UIImage(named: "Alicorn-app-35"), for: .normal)
        cameraAccessBtn.isUserInteractionEnabled = false
    }
    @IBAction func signUpAirCornAcion (_ sender: UIButton)
    {
        
    }

}
