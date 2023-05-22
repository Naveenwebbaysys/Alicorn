//
//  LicenceViewController.swift
//  Alicorn
//
//  Created by Mac on 09/05/23.
//

import UIKit

class LicenceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backBtnAction (_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }

}
