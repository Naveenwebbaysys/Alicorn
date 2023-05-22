//
//  BusinessTypeViewController.swift
//  Alicorn
//
//  Created by Mac on 04/05/23.
//

import UIKit

class BusinessTypeViewController: UIViewController {
    
    @IBOutlet weak var personalBtn : UIButton!
    @IBOutlet weak var businessBtn : UIButton!
    @IBOutlet weak var trackBtn : UIButton!
    @IBOutlet weak var shipBtn : UIButton!
    @IBOutlet weak var pickUpBtn : UIButton!
    @IBOutlet weak var getRatesBtn : UIButton!
    
       override func viewDidLoad() {
        super.viewDidLoad()

           
    
    }
    

    @IBAction func backBtnAction (_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continueBtnAction(sender : UIButton)
    {
        let getStartedVC = self.storyboard?.instantiateViewController(identifier: "GetStartedViewController") as! GetStartedViewController
        self.navigationController?.pushViewController(getStartedVC, animated: true)
    }
    
    @IBAction func personalBtnAcion (_ sender: UIButton)
    {
        personalBtn.setImage(UIImage(named: "Alicorn-app-35"), for: .normal)
        personalBtn.isUserInteractionEnabled = false
    }
    @IBAction func businessBtnAcion (_ sender: UIButton)
    {
        businessBtn.setImage(UIImage(named: "Alicorn-app-35"), for: .normal)
        businessBtn.isUserInteractionEnabled = false
    }
    @IBAction func trackBtnAcion (_ sender: UIButton)
    {
        trackBtn.setImage(UIImage(named: "Alicorn-app-35"), for: .normal)
        trackBtn.isUserInteractionEnabled = false
    }
    @IBAction func shipBtnAcion (_ sender: UIButton)
    {
        shipBtn.setImage(UIImage(named: "Alicorn-app-35"), for: .normal)
        shipBtn.isUserInteractionEnabled = false
    }
    @IBAction func pickUpBtnAcion (_ sender: UIButton)
    {
        pickUpBtn.setImage(UIImage(named: "Alicorn-app-35"), for: .normal)
        pickUpBtn.isUserInteractionEnabled = false
    }
    @IBAction func getRatesBtnAcion (_ sender: UIButton)
    {
        getRatesBtn.setImage(UIImage(named: "Alicorn-app-35"), for: .normal)
        getRatesBtn.isUserInteractionEnabled = false
    }

}
